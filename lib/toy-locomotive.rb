require "rails/all"
require "toy-locomotive/version"

module ToyLocomotive

  module Router; end
  module Resources; end
  module Attributes; end
  module AutoViews; end
  mattr_accessor :routes

end

require "toy-locomotive/router/model"
require "toy-locomotive/router/controller"
require "toy-locomotive/router/block"
require "toy-locomotive/resources/plural"
require "toy-locomotive/resources/singular"
require "toy-locomotive/attributes/chain"
require "toy-locomotive/attributes/model"
require "toy-locomotive/attributes/observer"
require "toy-locomotive/auto_views/show"
require "toy-locomotive/auto_views/form"
require "toy-locomotive/initializer"
