require File.dirname(__FILE__) + '/../../spec_helper'
include WillPaginate

describe "/ranks/gets.html.erb" do
  include RanksHelper
  
  before(:each) do
    rank_1 = mock_model(Rank)
    rank_2 = mock_model(Rank)

    @ranks = Rank.paginate :page => params[:page]
    assigns[:ranks] = @ranks
  end

  it "should render list of ranks" do
    render "/ranks/gets.html.erb"
  end
end

