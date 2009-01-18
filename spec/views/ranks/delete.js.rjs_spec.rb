require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ranks/delete.js.rjs" do
  include RanksHelper
  
  before do
    @rank = mock_model( Rank )
    @rank.stub!( :id ).and_return( 1 )
    @rank.stub!(:name).and_return("MyString")
    @rank.stub!(:user_id).and_return("1")
    assigns[:rank] = @rank
  end

  it "should remove the rank from the table" do
    render "/ranks/delete.js.rjs"
#    response.should have_rjs( :fade, @rank.id.to_s )
  end
end

