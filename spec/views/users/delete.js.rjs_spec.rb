require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/delete.js.rjs" do
  include UsersHelper
  
  before do
    @user = mock_model( User )
    @user.stub!( :id ).and_return( 1 )
    @user.stub!(:name).and_return("MyString")
    assigns[:user] = @user
  end

  it "should remove the user from the table" do
    render "/users/delete.js.rjs"
#    response.should have_rjs( :fade, @user.id.to_s )
  end
end

