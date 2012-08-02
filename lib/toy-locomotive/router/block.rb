module ToyLocomotive::Router::Block

  def draw *args
    (@_draws ||= []).push args
  end

  def draws
    @_draws || []
  end

end

ActionController::Base.extend ToyLocomotive::Router::Block
