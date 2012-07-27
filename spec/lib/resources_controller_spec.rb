require 'spec_helper'

describe DogsController do
  describe 'extract_resources' do

    it 'acepts :all as param' do
      DogsController.extract_resources(:all).should == [:index, :new, :create, :show, :edit, :update, :destroy]
    end
    it 'acepts :only as param' do
      DogsController.extract_resources(only: [:index, :show]).should == [:index, :show]
    end
    it 'acepts :except as param' do
      DogsController.extract_resources(except: [:index, :destroy]).should == [:new, :create, :show, :edit, :update]
    end
  end

  describe 'set_action' do
    it "executes index" do
      DogsController.resources(only: [:index])
      DogsController.new.index.class.should == Array
    end

    it "executes new" do
      DogsController.resources(only: [:new])
      DogsController.new.new.human.should == Human.first
    end

    it "executes show" do
      DogsController.resources(only: [:show])
      DogsController.new.show.should == Dog.first
    end

    it "executes edit" do
      DogsController.resources(only: [:edit])
      DogsController.new.show.should == Dog.first
    end

  end
end
