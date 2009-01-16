require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  describe "route generation" do

    it "should map { :controller => 'users', :action => 'gets', :method => 'get' } to /users" do
      route_for( :controller => 'users', :action => 'gets', :method => 'get' ).should == "/users"
    end
  
    it "should map { :controller => 'users', :action => 'get', :method => 'get' } to /user" do
      route_for( :controller => 'users', :action => 'get', :method => 'get' ).should == "/user"
    end
  
  end

  describe "route recognition" do

    it "should generate params { :controller => 'users', action => 'gets' } from GET /users" do
      params_from( :get, "/users" ).should == { :controller => 'users', :action => 'gets' }
    end
  
    it "should generate params { :controller => 'users', action => 'get' } from GET /user" do
      params_from( :get, "/user" ).should == { :controller => 'users', :action => 'get' }
    end

  end
end
