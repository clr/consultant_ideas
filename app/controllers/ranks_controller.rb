class RanksController < ApplicationController

  before_filter :prepare_restful_interpretation

  # Plural methods.
  def gets
    parse_search
    parse_sort_order
    
    @ranks = Rank.paginate :page => params[:page], :per_page => 7, :conditions => @conditions, :order => @order

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

=begin
  def post
    respond_to do |format|
      if @rank = Rank.create( params[:rank] )
        flash[:notice] = 'Rank was successfully created.'
        format.html { redirect_to( rank_url( @rank ) ) }
      else
        format.html { render :action => 'get' }
      end
    end
  end

  def put
    respond_to do |format|
      if @rank.update_attributes( params[:rank] )
        flash[:notice] = 'Rank was successfully updated.'
        format.html { redirect_to( rank_url( @rank ) ) }
      else
        format.html { render :action => 'get' }
      end
    end
  end
=end

  def post
    params[:rank][:user_id] = current_user.id unless ( params[:rank][:user_id] && params[:rank][:user_id].length > 0 )
    respond_to do |format|
      if @rank = Rank.create( params[:rank] )
        save_idea_rankings
        flash[:notice] = 'Rank was successfully created.'
        format.html { redirect_to( rank_path( @rank ) ) }
      else
        format.html { render :action => 'get' }
      end
    end
  end

  def put
    params[:rank][:user_id] = current_user.id unless ( params[:rank][:user_id] && params[:rank][:user_id].length > 0 )
    respond_to do |format|
      @rank.update_attributes( params[:rank] )
      if !@rank.changed?
        save_idea_rankings
        flash[:notice] = 'Rank was successfully updated.'
        format.html { redirect_to( rank_path( @rank ) ) }
      else
        format.html { render :action => 'get' }
      end
    end
  end

  def delete
    @rank.destroy

    respond_to do |format|
      format.js
    end
  end

  protected
    def prepare_restful_interpretation
      case params[:grammatical_number]
      when 'plural'
        self.action_name = self.request.request_method.to_s.pluralize
        @ranks = Rank.find( params[:ids].split( ',' ) ) if params[:ids]
      when 'singular'
        self.action_name = self.request.request_method.to_s.singularize
        if params[:id].to_i == 0
          @rank = Rank.new
        else
          @rank = Rank.find( params[:id] ) if params[:id]
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

    # Save 'ideas' sortable collection.
    def save_idea_rankings
      @rank.idea_rankings.clear
      params[:ideas].each_with_index do |resource_pair, i|
        resource_class, resource_id = resource_pair.split( ':' )
        if resource = resource_class.camelize.constantize.find( resource_id )
          IdeaRanking.create( 
            :rank_id => @rank.id, 
            :idea_id => resource.id, 
            :position => ( i + 1 )
          )
        end
      end unless params[:ideas].nil?
      @rank.reload
    end

end
