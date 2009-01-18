require File.dirname(__FILE__) + '/../spec_helper'

describe RanksController do
  describe "handling GET /ranks" do

    before(:each) do
      @rank = mock_model( Rank )
      Rank.stub!( :find ).and_return( [ @rank ] )
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template( 'index' )
    end
  
    it "should find all ranks" do
      Rank.should_receive( :paginate ).with( { :page => params[:page], :per_page => 7 } ).and_return( [ @rank ] )
      do_get
    end
  
    it "should assign the found ranks for the view" do
      do_get
      assigns( :ranks ).should == [ @rank ]
    end
  end

  describe "handling GET /ranks/1" do

    before( :each ) do
      @rank = mock_model( Rank )
      Rank.stub!( :find ).and_return( @rank )
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template( 'form' )
    end
  
    it "should find the rank requested" do
      Rank.should_receive( :find ).with( "1" ).and_return( @rank )
      do_get
    end
  
    it "should assign the found rank for the view" do
      do_get
      assigns( :rank ).should equal( @rank )
    end
  end

  describe "handling GET /ranks/new" do

    before( :each ) do
      @rank = mock_model( Rank )
      Rank.stub!( :new ).and_return( @rank )
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template( 'form' )
    end
  
    it "should create an new rank" do
      Rank.should_receive( :new ).and_return( @rank )
      do_get
    end
  
    it "should not save the new rank" do
      @rank.should_not_receive( :save )
      do_get
    end
  
    it "should assign the new rank for the view" do
      do_get
      assigns( :rank ).should equal( @rank )
    end
  end

  describe "handling POST /ranks" do

    before( :each ) do
      @rank = mock_model( Rank, :to_param => "1" )
      Rank.stub!( :new ).and_return( @rank )
    end
    
    describe "with successful save" do
  
      def do_post
        @rank.should_receive( :save ).and_return( true )
        post :create, :rank => {}
      end
  
      it "should create a new rank" do
        Rank.should_receive( :new ).with( {} ).and_return( @rank )
        do_post
      end

      it "should redirect to the index for ranks" do
        do_post
        response.should redirect_to( ranks_url )
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @rank.should_receive( :save ).and_return( false )
        post :create, :rank => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template( 'form' )
      end
      
    end
  end

  describe "handling PUT /ranks/1" do

    before( :each ) do
      @rank = mock_model( Rank, :to_param => "1" )
      Rank.stub!( :find ).and_return( @rank )
    end
    
    describe "with successful update" do

      def do_put
        @rank.should_receive( :update_attributes ).and_return( true )
        put :update, :id => "1"
      end

      it "should find the rank requested" do
        Rank.should_receive( :find ).with( "1" ).and_return( @rank )
        do_put
      end

      it "should update the found rank" do
        do_put
        assigns( :rank ).should equal( @rank )
      end

      it "should assign the found rank for the view" do
        do_put
        assigns( :rank ).should equal( @rank )
      end

      it "should redirect to the index for ranks" do
        do_put
        response.should redirect_to( ranks_url )
      end

    end
    
    describe "with failed update" do

      def do_put
        @rank.should_receive( :update_attributes ).and_return( false )
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template( 'form' )
      end

    end
  end

  describe "handling DELETE /ranks/1" do

    before( :each ) do
      @rank = mock_model( Rank, :destroy => true )
      Rank.stub!( :find ).and_return( @rank )
    end
  
    def do_delete
      @request.env["HTTP_ACCEPT"] = "application/javascript"
      delete :destroy, :id => "1"
    end

    it "should find the rank requested" do
      Rank.should_receive( :find ).with( "1" ).and_return( @rank )
      do_delete
    end
  
    it "should call destroy on the found rank" do
      @rank.should_receive( :destroy )
      do_delete
    end
  
    it "should render the rjs" do
      do_delete
      response.should render_template( 'destroy' )
    end
  end
end
