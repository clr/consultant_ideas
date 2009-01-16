require File.dirname(__FILE__) + '/../../spec_helper'
include WillPaginate

describe "/users/gets.html.erb" do
  include UsersHelper
  
  before(:each) do
    user_1 = mock_model(User)
    user_2 = mock_model(User)

    @users = User.paginate :page => params[:page]
    assigns[:users] = @users
  end

  it "should render list of users" do
    render "/users/gets.html.erb"
  end
end

