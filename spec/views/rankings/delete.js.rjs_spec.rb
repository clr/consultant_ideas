require File.dirname(__FILE__) + '/../../spec_helper'

describe "/rankings/delete.js.rjs" do
  include RankingsHelper
  
  before do
    @rankings = mock_model( Rankings )
    @rankings.stub!( :id ).and_return( 1 )
    @rankings.stub!(:user_id).and_return("1")
    assigns[:rankings] = @rankings
  end

  it "should remove the rankings from the table" do
    render "/rankings/delete.js.rjs"
#    response.should have_rjs( :fade, @rankings.id.to_s )
  end
end

