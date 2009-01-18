require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ranks/get.html.erb" do
  include RanksHelper
  
  before(:each) do
    @rank = mock_model(Rank)
    @rank.stub!(:name).and_return("MyString")
    @rank.stub!(:user_id).and_return("1")

    assigns[:rank] = @rank
  end

  it "should render attributes in <p>" do
    render "/ranks/get.html.erb"
    response.should have_text(/MyString/)
  end
end

