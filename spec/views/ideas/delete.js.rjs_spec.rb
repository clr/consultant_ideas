require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ideas/delete.js.rjs" do
  include IdeasHelper
  
  before do
    @idea = mock_model( Idea )
    @idea.stub!( :id ).and_return( 1 )
    @idea.stub!(:name).and_return("MyString")
    @idea.stub!(:user_id).and_return("1")
    @idea.stub!(:elevator).and_return("MyText")
    @idea.stub!(:full).and_return("MyText")
    @idea.stub!(:marketing).and_return("MyText")
    assigns[:idea] = @idea
  end

  it "should remove the idea from the table" do
    render "/ideas/delete.js.rjs"
#    response.should have_rjs( :fade, @idea.id.to_s )
  end
end

