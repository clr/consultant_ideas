require File.dirname(__FILE__) + '/../spec_helper'

describe RankingsController do
  describe "handling GET /rankings" do

    before(:each) do
      @rankings = mock_model( Rankings )
      Rankings.stub!( :find ).and_return( [ @rankings ] )
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
  
    it "should find all rankings" do
      Rankings.should_receive( :paginate ).with( { :page => params[:page], :per_page => 7 } ).and_return( [ @rankings ] )
      do_get
    end
  
    it "should assign the found rankings for the view" do
      do_get
      assigns( :rankings ).should == [ @rankings ]
    end
  end

  describe "handling GET /rankings/1" do

    before( :each ) do
      @rankings = mock_model( Rankings )
      Rankings.stub!( :find ).and_return( @rankings )
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
  
    it "should find the rankings requested" do
      Rankings.should_receive( :find ).with( "1" ).and_return( @rankings )
      do_get
    end
  
    it "should assign the found rankings for the view" do
      do_get
      assigns( :rankings ).should equal( @rankings )
    end
  end

  describe "handling GET /rankings/new" do

    before( :each ) do
      @rankings = mock_model( Rankings )
      Rankings.stub!( :new ).and_return( @rankings )
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
  
    it "should create an new rankings" do
      Rankings.should_receive( :new ).and_return( @rankings )
      do_get
    end
  
    it "should not save the new rankings" do
      @rankings.should_not_receive( :save )
      do_get
    end
  
    it "should assign the new rankings for the view" do
      do_get
      assigns( :rankings ).should equal( @rankings )
    end
  end

  describe "handling POST /rankings" do

    before( :each ) do
      @rankings = mock_model( Rankings, :to_param => "1" )
      Rankings.stub!( :new ).and_return( @rankings )
    end
    
    describe "with successful save" do
  
      def do_post
        @rankings.should_receive( :save ).and_return( true )
        post :create, :rankings => {}
      end
  
      it "should create a new rankings" do
        Rankings.should_receive( :new ).with( {} ).and_return( @rankings )
        do_post
      end

      it "should redirect to the index for rankings" do
        do_post
        response.should redirect_to( rankings_url )
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @rankings.should_receive( :save ).and_return( false )
        post :create, :rankings => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template( 'form' )
      end
      
    end
  end

  describe "handling PUT /rankings/1" do

    before( :each ) do
      @rankings = mock_model( Rankings, :to_param => "1" )
      Rankings.stub!( :find ).and_return( @rankings )
    end
    
    describe "with successful update" do

      def do_put
        @rankings.should_receive( :update_attributes ).and_return( true )
        put :update, :id => "1"
      end

      it "should find the rankings requested" do
        Rankings.should_receive( :find ).with( "1" ).and_return( @rankings )
        do_put
      end

      it "should update the found rankings" do
        do_put
        assigns( :rankings ).should equal( @rankings )
      end

      it "should assign the found rankings for the view" do
        do_put
        assigns( :rankings ).should equal( @rankings )
      end

      it "should redirect to the index for rankings" do
        do_put
        response.should redirect_to( rankings_url )
      end

    end
    
    describe "with failed update" do

      def do_put
        @rankings.should_receive( :update_attributes ).and_return( false )
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template( 'form' )
      end

    end
  end

  describe "handling DELETE /rankings/1" do

    before( :each ) do
      @rankings = mock_model( Rankings, :destroy => true )
      Rankings.stub!( :find ).and_return( @rankings )
    end
  
    def do_delete
      @request.env["HTTP_ACCEPT"] = "application/javascript"
      delete :destroy, :id => "1"
    end

    it "should find the rankings requested" do
      Rankings.should_receive( :find ).with( "1" ).and_return( @rankings )
      do_delete
    end
  
    it "should call destroy on the found rankings" do
      @rankings.should_receive( :destroy )
      do_delete
    end
  
    it "should render the rjs" do
      do_delete
      response.should render_template( 'destroy' )
    end
  end
end
