require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ideas/get.html.erb" do
  include IdeasHelper
  
  before(:each) do
    @idea = mock_model(Idea)
    @idea.stub!(:name).and_return("MyString")
    @idea.stub!(:user_id).and_return("1")
    @idea.stub!(:elevator).and_return("MyText")
    @idea.stub!(:full).and_return("MyText")
    @idea.stub!(:marketing).and_return("MyText")

    assigns[:idea] = @idea
  end

  it "should render attributes in <p>" do
    render "/ideas/get.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
    response.should have_text(/MyText/)
    response.should have_text(/MyText/)
  end
end

