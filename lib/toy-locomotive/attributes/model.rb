module ToyLocomotive::Attributes::Model
  module ClassMethods

    mattr_accessor :toy_attributes
    self.toy_attributes = []

    def attribute value
      tattr = ToyLocomotive::Attributes::AttributeChain.new value, self
      self.toy_attributes << tattr
      tattr
    end

    def attributes
      toy_attributes.select{|a| a.parent == self}
    end

    def use_toy_attributes?
      true
    end

  end
end
ActiveRecord::Base.extend ToyLocomotive::Attributes::Model::ClassMethods
