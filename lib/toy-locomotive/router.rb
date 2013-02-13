module ToyLocomotive::Router

  def toy_locomotive
    toy_resources if responds_to(:toy_resources)
    toy_verbs if responds_to(:toy_verbs)
  end

end

ActionDispatch::Routing::Mapper.send :include, ToyLocomotive::Router
