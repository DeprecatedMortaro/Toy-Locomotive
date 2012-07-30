module ToyLocomotive::Router::Block

  mattr_accessor :_draws

  def draw *args
    (@_draws ||= []).push args
  end

end

ActionController::Base.extend ToyLocomotive::Router::Block
