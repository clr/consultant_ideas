require File.dirname(__FILE__) + '/../spec_helper'

describe IdeasController do
  describe "route generation" do

    it "should map { :controller => 'ideas', :action => 'gets', :method => 'get' } to /ideas" do
      route_for( :controller => 'ideas', :action => 'gets', :method => 'get' ).should == "/ideas"
    end
  
    it "should map { :controller => 'ideas', :action => 'get', :method => 'get' } to /idea" do
      route_for( :controller => 'ideas', :action => 'get', :method => 'get' ).should == "/idea"
    end
  
  end

  describe "route recognition" do

    it "should generate params { :controller => 'ideas', action => 'gets' } from GET /ideas" do
      params_from( :get, "/ideas" ).should == { :controller => 'ideas', :action => 'gets' }
    end
  
    it "should generate params { :controller => 'ideas', action => 'get' } from GET /idea" do
      params_from( :get, "/idea" ).should == { :controller => 'ideas', :action => 'get' }
    end

  end
end
