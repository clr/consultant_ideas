require File.dirname(__FILE__) + '/../../spec_helper'

describe "/rankings/get.html.erb" do
  include RankingsHelper
  
  before(:each) do
    @rankings = mock_model(Rankings)
    @rankings.stub!(:user_id).and_return("1")

    assigns[:rankings] = @rankings
  end

  it "should render attributes in <p>" do
    render "/rankings/get.html.erb"
  end
end

