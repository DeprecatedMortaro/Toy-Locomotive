module ToyLocomotive::Router::Block

  mattr_accessor :_routes

  def route *args
    (@_routes ||= []).push args
  end

end

ActionController::Base.extend ToyLocomotive::Router::Block
