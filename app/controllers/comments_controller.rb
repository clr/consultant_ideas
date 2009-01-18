class CommentsController < ApplicationController

  before_filter :prepare_restful_interpretation

  def post
    respond_to do |format|
      params[:comment][:user_id] = current_user.id
      if @comment = Comment.create( params[:comment] )
        flash[:notice] = 'Idea was successfully created.'
        format.js { render :partial => 'comments/get', :object => @comment }
      else
        format.js { render :text => "'alert( whoops!' )" }
      end
    end
  end

  protected
    def prepare_restful_interpretation
      case params[:grammatical_number]
      when 'plural'
        self.action_name = self.request.request_method.to_s.pluralize
        @comments = Comment.find( params[:ids].split( ',' ) ) if params[:ids]
      when 'singular'
        self.action_name = self.request.request_method.to_s.singularize
        if params[:id].to_i == 0
          @comment = Comment.new
        else
          @comment = Comment.find( params[:id] ) if params[:id]
        end
      end
    end

end
