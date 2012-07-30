module ToyLocomotive::Router::Block

  mattr_accessor :_route

  def route &block
    @_route = block
  end

end

ActionController::Base.extend ToyLocomotive::Router::Block
