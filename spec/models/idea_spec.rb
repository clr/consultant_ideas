require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Idea do
  before(:each) do
    @valid_attributes = {
      :name => "MyString",
      :user_id => "1",
      :elevator => "MyText",
      :full => "MyText",
      :marketing => "MyText"
    }
  end

  it "should create a new instance given valid attributes" do
    Idea.create!(@valid_attributes)
  end
end
