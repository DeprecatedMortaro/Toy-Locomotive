require 'spec_helper'

describe ToyLocomotive::Attributes::AttributeChain do

  subject{ ToyLocomotive::Attributes::AttributeChain.new :title, Dog }

  its(:parent){should == Dog}
  its(:column){should == :title}

  it "defaults as string" do
    subject._as.should == :string
  end

  it "changes the type" do
    subject.as(:text)._as == :text
  end

  it "use text_field as helper for strings as default" do
    subject.as(:string).to_helper.should == :text_field
  end

  it "use text_area as helper for text as default" do
    subject.as(:text).to_helper.should == :text_area
  end

  it "use hidden_field as helper for ids as default" do
    attribute = ToyLocomotive::Attributes::AttributeChain.new :id, Dog
    attribute.to_helper.should == :hidden_field
  end

  it "use hidden_field as helper for relational ids as default" do
    attribute = ToyLocomotive::Attributes::AttributeChain.new :human_id, Dog
    attribute.to_helper.should == :hidden_field
  end

  it "acepts new helper" do
    subject.helper(:text_area).to_helper.should == :text_area
  end

end
