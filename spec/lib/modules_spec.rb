require 'spec_helper'

describe ToyLocomotive do
  it "should include Toy Attributes" do
    defined?(ToyAttributes).should be_true
  end

  it "should include Toy Verbs" do
    defined?(ToyVerbs).should be_true
  end

  it "should include Toy Resources" do
    defined?(ToyResources).should be_true
  end
end
