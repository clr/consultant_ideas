class IdeasController < ApplicationController

  before_filter :prepare_restful_interpretation

  # Plural methods.
  def gets
    parse_search
    parse_sort_order
    
    @ideas = Idea.paginate :page => params[:page], :per_page => 7, :conditions => @conditions, :order => @order

    respond_to do |format|
      format.html
    end
  end

  # Singular methods.
  def get
    respond_to do |format|
      format.html
    end
  end

  def post
    respond_to do |format|
      if @idea = Idea.create( params[:idea] )
        flash[:notice] = 'Idea was successfully created.'
        format.html { redirect_to( idea_url( @idea ) ) }
      else
        format.html { render :action => 'get' }
      end
    end
  end

  def put
    respond_to do |format|
      if @idea.update_attributes( params[:idea] )
        flash[:notice] = 'Idea was successfully updated.'
        format.html { redirect_to( idea_url( @idea ) ) }
      else
        format.html { render :action => 'get' }
      end
    end
  end

  def delete
    @idea.destroy

    respond_to do |format|
      format.js
    end
  end

  protected
    def prepare_restful_interpretation
      case params[:grammatical_number]
      when 'plural'
        self.action_name = self.request.request_method.to_s.pluralize
        @ideas = Idea.find( params[:ids].split( ',' ) ) if params[:ids]
      when 'singular'
        self.action_name = self.request.request_method.to_s.singularize
        if params[:id].to_i == 0
          @idea = Idea.new
        else
          @idea = Idea.find( params[:id] ) if params[:id]
        end
      end
    end
    
    # Put search conditions in here.
    def parse_search
      return false unless params[:search]
      @conditions ||= []
      %w( name ).each do |column|
        @conditions << ActiveRecord::Base.send( :sanitize_sql_array, [ "LOWER(#{ column }) LIKE ?", "%%#{ params[:search] || "" }%%" ] )
      end
    end

    # Put 'order by' style conditions in here.
    def parse_sort_order
      return false unless params[:sort_order]
      order_by ||= []
      params[:sort_order].split( ';' ).each do |pair|
        column, direction = pair.split( ':' )
        order_by << "#{ column } #{ direction == 'up' ? 'DESC' : 'ASC' }"
      end
      @order = order_by * ", "
    end

    # Put filtering conditions in here, for enumerated column data.
    def parse_filter
      @conditions ||= []
      %w( name ).each do |column|
        param_key = ( column + "_filter" ).to_sym
        if params[ param_key ] && params[ param_key ].length > 0 
          field = field_of_interest( column )
          @conditions << ActiveRecord::Base.send( :sanitize_sql_array, [ "LOWER(#{ column.pluralize }.#{ field }) LIKE ?", '%' + params[ param_key ].clean_query_string + '%' ] ) if ( !field.nil? && params[ param_key ].clean_query_string.length > 0 )
        end
      end
    end

end
