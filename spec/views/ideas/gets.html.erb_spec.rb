require File.dirname(__FILE__) + '/../../spec_helper'
include WillPaginate

describe "/ideas/gets.html.erb" do
  include IdeasHelper
  
  before(:each) do
    idea_1 = mock_model(Idea)
    idea_2 = mock_model(Idea)

    @ideas = Idea.paginate :page => params[:page]
    assigns[:ideas] = @ideas
  end

  it "should render list of ideas" do
    render "/ideas/gets.html.erb"
  end
end

