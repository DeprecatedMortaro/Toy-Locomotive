module ToyLocomotive::Router::Model

  #def belongs_to_route
  #  reflections = reflect_on_all_associations(:belongs_to)
  #  reflections.any? ? reflections.first.name.to_s.camelize.constantize : nil
  #end

  #def belongs_chain chain=[]
  #  parent_route = (chain.last || self).belongs_to_route
  #  parent_route ? belongs_chain(chain << parent_route) : chain
  #end

  #def route_chain
  #  belongs_chain.reverse.map{|m| m.to_route}.join
  #end

  def to_route
    s = to_s.parameterize.downcase
    "/#{s.pluralize}/:#{s}_id"
  end

  def to_member_var
    "@#{to_s.underscore}"
  end

  def to_collection_var
    to_member_var.pluralize
  end

  def to_params
    :"#{to_s.underscore}_id"
  end

  def to_as
    belongs_chain.reverse!.map{|m| m.to_s.underscore }.join('_') << (belongs_chain.empty? ? to_s.underscore : "_#{to_s.underscore}")
  end

end

ActiveRecord::Base.extend ToyLocomotive::Router::Model
