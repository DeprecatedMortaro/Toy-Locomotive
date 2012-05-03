require 'spec_helper'

describe DogsController do

  subject { DogsController }

  its(:extract_model) {should == Dog}
  its(:extract_controller) {should == 'dogs'}

  [:get, :put, :post, :delete].each {|via| it { should respond_to(via) }}

  it "extracts vars" do
    dog_controller = DogsController.new
    dog_controller.extract_parent_vars[0].class.should == Alien
    dog_controller.extract_parent_vars[1].class.should == Human
    dog_controller.extract_member_var.class.should == Dog
    dog_controller.extract_collection_var.class.should == Array
    dog_controller.extract_collection_var.first.class.should == Dog
  end

  describe '.extract_action' do
    it "recognizes the root" do
      DogsController.extract_action('/').should == 'root'
    end

    it "returns the option :as if declared" do
      DogsController.extract_action('lorem-ipsum', as: 'dolor-sit').should == 'dolor_sit'
    end

    it "returns the path if no options" do
      DogsController.extract_action('lorem-ipsum').should == 'lorem_ipsum'
    end
  end

  describe '.extract_as' do
    it "returns the action if its absolute path" do
      DogsController.extract_as('/lorem-ipsum').should == 'lorem_ipsum'
    end

    it "returns the chain as method if its relative path" do
      DogsController.extract_as('lorem').should == 'lorem_alien_human_dog'
    end
  end

  describe '.extract_path' do
    it "returns itself if absolute path" do
      DogsController.extract_path('/lorem').should == '/lorem'
    end

    it "matches relative path on member" do
      DogsController.extract_path('lorem', on: 'member').should == '/aliens/:alien_id/humans/:human_id/dogs/:dog_id/lorem'
    end

    it "matches relative path on collection" do
      DogsController.extract_path('lorem', on: 'collection').should == '/aliens/:alien_id/humans/:human_id/dogs/lorem'
    end
  end

  describe '.get' do
    it "adds a empty method" do
      DogsController.get('/lorem'){}
      DogsController.new.should respond_to(:lorem)
    end

    it "adds a method from a block" do
      DogsController.get('/lorem') { 'lorem-ipsum' }
      DogsController.new.lorem.should == 'lorem-ipsum'
    end
  end

end
