require File.dirname(__FILE__) + '/../../spec_helper'
include WillPaginate

describe "/rankings/gets.html.erb" do
  include RankingsHelper
  
  before(:each) do
    rankings_1 = mock_model(Rankings)
    rankings_2 = mock_model(Rankings)

    @rankings = Rankings.paginate :page => params[:page]
    assigns[:rankings] = @rankings
  end

  it "should render list of rankings" do
    render "/rankings/gets.html.erb"
  end
end

