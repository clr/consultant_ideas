class IdeaRankingsController < ApplicationController
  before_filter :prepare_instance_variables

  # Singular methods.
  def get
    respond_to do |format|
      format.js do
        raise "Object not found." unless @idea = Idea.find( params[:object_id] )
        @idea_ranking.idea = @idea
        render :partial => 'idea_rankings/get', :object => @idea_ranking
      end
    end
  end

  protected
    def prepare_instance_variables
      @idea_ranking, @idea_rankings = prepare_restful_interpretation( :idea_ranking )
    end

end
