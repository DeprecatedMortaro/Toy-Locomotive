module ToyLocomotive::Router::Model

  def self.belongs_to_route
    reflections = reflect_on_all_associations(:belongs_to)
    reflections.any? ? reflections.first.name.to_s.camelize.constantize : nil
  end

  def self.belongs_chain chain=[]
    parent_route = (chain.last || self).belongs_to_route
    parent_route ? belongs_chain(chain << parent_route) : chain
  end

  def self.route_chain
    belongs_chain.reverse.map{|m| m.to_route}.join
  end

  def self.to_route
    s = to_s.parameterize.downcase
    "/#{s.pluralize}/:#{s}_id"
  end

  def self.to_member_var
    "@#{to_s.underscore}"
  end

  def self.to_collection_var
    to_member_var.pluralize
  end

  def self.to_params
    :"#{to_s.underscore}_id"
  end

end

ActiveRecord::Base.send :include, ToyLocomotive::Router::Model
