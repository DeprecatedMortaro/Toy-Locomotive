require 'spec_helper'

describe Dog do

  subject { Dog }

  { to_params: :dog_id,
    to_collection_var: '@dogs',
    to_member_var: '@dog',
    to_route: '/dogs/:dog_id',
    route_chain: '/aliens/:alien_id/humans/:human_id',
    belongs_chain: [Human, Alien],
    belongs_to_route: Human,
    to_as: 'alien_human_dog'
  }.each{|method, expectation| its(method) {should == expectation}}

end

describe Human do

  subject { Human }

  { to_params: :human_id,
    to_collection_var: '@humans',
    to_member_var: '@human',
    to_route: '/humans/:human_id',
    route_chain: '/aliens/:alien_id',
    belongs_chain: [Alien],
    belongs_to_route: Alien,
    to_as: 'alien_human'
  }.each{|method, expectation| its(method) {should == expectation}}

end

describe Alien do

  subject { Alien }

  { to_params: :alien_id,
    to_collection_var: '@aliens',
    to_member_var: '@alien',
    to_route: '/aliens/:alien_id',
    route_chain: '',
    belongs_chain: [],
    belongs_to_route: nil,
    to_as: 'alien'
  }.each{|method, expectation| its(method) {should == expectation}}

end
