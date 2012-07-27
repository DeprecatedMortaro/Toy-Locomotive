require 'spec_helper'

describe Dog do

  it "acepts attributes" do
    Dog.attribute(:title)
    Dog.toy_attributes.first.column.should == :title
  end

end
