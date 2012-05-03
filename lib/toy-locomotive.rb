require "rails/all"
require "toy-locomotive/version"

module ToyLocomotive

  module Router; end
  mattr_accessor :routes

end

require "toy-locomotive/router/model"
require "toy-locomotive/router/controller"
require "toy-locomotive/initializer"
