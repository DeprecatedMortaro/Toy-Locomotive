require 'spec_helper'

describe Dog do

  it "responds to params" do
    Dog.should respond_to :to_params
  end

  it "converts to params" do
    Dog.to_params.should == :dog_id
  end

end
