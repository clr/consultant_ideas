require File.dirname(__FILE__) + '/../spec_helper'

describe IdeasController do
  describe "handling GET /ideas" do

    before(:each) do
      @idea = mock_model( Idea )
      Idea.stub!( :find ).and_return( [ @idea ] )
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
  
    it "should find all ideas" do
      Idea.should_receive( :paginate ).with( { :page => params[:page], :per_page => 7 } ).and_return( [ @idea ] )
      do_get
    end
  
    it "should assign the found ideas for the view" do
      do_get
      assigns( :ideas ).should == [ @idea ]
    end
  end

  describe "handling GET /ideas/1" do

    before( :each ) do
      @idea = mock_model( Idea )
      Idea.stub!( :find ).and_return( @idea )
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
  
    it "should find the idea requested" do
      Idea.should_receive( :find ).with( "1" ).and_return( @idea )
      do_get
    end
  
    it "should assign the found idea for the view" do
      do_get
      assigns( :idea ).should equal( @idea )
    end
  end

  describe "handling GET /ideas/new" do

    before( :each ) do
      @idea = mock_model( Idea )
      Idea.stub!( :new ).and_return( @idea )
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
  
    it "should create an new idea" do
      Idea.should_receive( :new ).and_return( @idea )
      do_get
    end
  
    it "should not save the new idea" do
      @idea.should_not_receive( :save )
      do_get
    end
  
    it "should assign the new idea for the view" do
      do_get
      assigns( :idea ).should equal( @idea )
    end
  end

  describe "handling POST /ideas" do

    before( :each ) do
      @idea = mock_model( Idea, :to_param => "1" )
      Idea.stub!( :new ).and_return( @idea )
    end
    
    describe "with successful save" do
  
      def do_post
        @idea.should_receive( :save ).and_return( true )
        post :create, :idea => {}
      end
  
      it "should create a new idea" do
        Idea.should_receive( :new ).with( {} ).and_return( @idea )
        do_post
      end

      it "should redirect to the index for ideas" do
        do_post
        response.should redirect_to( ideas_url )
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @idea.should_receive( :save ).and_return( false )
        post :create, :idea => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template( 'form' )
      end
      
    end
  end

  describe "handling PUT /ideas/1" do

    before( :each ) do
      @idea = mock_model( Idea, :to_param => "1" )
      Idea.stub!( :find ).and_return( @idea )
    end
    
    describe "with successful update" do

      def do_put
        @idea.should_receive( :update_attributes ).and_return( true )
        put :update, :id => "1"
      end

      it "should find the idea requested" do
        Idea.should_receive( :find ).with( "1" ).and_return( @idea )
        do_put
      end

      it "should update the found idea" do
        do_put
        assigns( :idea ).should equal( @idea )
      end

      it "should assign the found idea for the view" do
        do_put
        assigns( :idea ).should equal( @idea )
      end

      it "should redirect to the index for ideas" do
        do_put
        response.should redirect_to( ideas_url )
      end

    end
    
    describe "with failed update" do

      def do_put
        @idea.should_receive( :update_attributes ).and_return( false )
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template( 'form' )
      end

    end
  end

  describe "handling DELETE /ideas/1" do

    before( :each ) do
      @idea = mock_model( Idea, :destroy => true )
      Idea.stub!( :find ).and_return( @idea )
    end
  
    def do_delete
      @request.env["HTTP_ACCEPT"] = "application/javascript"
      delete :destroy, :id => "1"
    end

    it "should find the idea requested" do
      Idea.should_receive( :find ).with( "1" ).and_return( @idea )
      do_delete
    end
  
    it "should call destroy on the found idea" do
      @idea.should_receive( :destroy )
      do_delete
    end
  
    it "should render the rjs" do
      do_delete
      response.should render_template( 'destroy' )
    end
  end
end
