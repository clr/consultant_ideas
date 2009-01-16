require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/get.html.erb" do
  include UsersHelper
  
  before(:each) do
    @user = mock_model(User)
    @user.stub!(:name).and_return("MyString")

    assigns[:user] = @user
  end

  it "should render attributes in <p>" do
    render "/users/get.html.erb"
    response.should have_text(/MyString/)
  end
end

