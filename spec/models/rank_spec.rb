require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rank do
  before(:each) do
    @valid_attributes = {
      :name => "MyString",
      :user_id => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Rank.create!(@valid_attributes)
  end
end
