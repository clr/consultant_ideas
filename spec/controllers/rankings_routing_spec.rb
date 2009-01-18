require File.dirname(__FILE__) + '/../spec_helper'

describe RankingsController do
  describe "route generation" do

    it "should map { :controller => 'rankings', :action => 'gets', :method => 'get' } to /rankings" do
      route_for( :controller => 'rankings', :action => 'gets', :method => 'get' ).should == "/rankings"
    end
  
    it "should map { :controller => 'rankings', :action => 'get', :method => 'get' } to /rankings" do
      route_for( :controller => 'rankings', :action => 'get', :method => 'get' ).should == "/rankings"
    end
  
  end

  describe "route recognition" do

    it "should generate params { :controller => 'rankings', action => 'gets' } from GET /rankings" do
      params_from( :get, "/rankings" ).should == { :controller => 'rankings', :action => 'gets' }
    end
  
    it "should generate params { :controller => 'rankings', action => 'get' } from GET /rankings" do
      params_from( :get, "/rankings" ).should == { :controller => 'rankings', :action => 'get' }
    end

  end
end
