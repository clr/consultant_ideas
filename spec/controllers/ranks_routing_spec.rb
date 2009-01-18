require File.dirname(__FILE__) + '/../spec_helper'

describe RanksController do
  describe "route generation" do

    it "should map { :controller => 'ranks', :action => 'gets', :method => 'get' } to /ranks" do
      route_for( :controller => 'ranks', :action => 'gets', :method => 'get' ).should == "/ranks"
    end
  
    it "should map { :controller => 'ranks', :action => 'get', :method => 'get' } to /rank" do
      route_for( :controller => 'ranks', :action => 'get', :method => 'get' ).should == "/rank"
    end
  
  end

  describe "route recognition" do

    it "should generate params { :controller => 'ranks', action => 'gets' } from GET /ranks" do
      params_from( :get, "/ranks" ).should == { :controller => 'ranks', :action => 'gets' }
    end
  
    it "should generate params { :controller => 'ranks', action => 'get' } from GET /rank" do
      params_from( :get, "/rank" ).should == { :controller => 'ranks', :action => 'get' }
    end

  end
end
