module ToyLocomotive::Router::Controller

  def self.get path, opts={}, &blk
    match_action "get", path, opts, blk
  end

  def self.match_action method, path, opts, blk

    action = extract_action(path, opts)

    extract_filter action, path, opts

    path = extract_path(path, opts)
    as = extract_as(path, opts)
    controller = extract_controller

    add_route method, action, path, as, controller
    define_method action, &blk

  end

  def self.add_route method, action, path, as, controller
    ToyLocomotive.routes ||= []
    ToyLocomotive.routes << {method: method, action: action, path: path, controller: controller, as: as}
  end

  def self.extract_path path, opts
    return path if path[0] == '/'
    "#{extract_model.route_chain}#{opts[:on] == 'member' ? extract_model.to_route : ''}/#{path.parameterize}"
  end

  def self.extract_as path, opts
    action = extract_action path, opts
    path[0] == '/' ? action : "some chain #{action}"
  end

  def self.extract_action path, opts
    opts[:as] || path.parameterize.underscore
  end

  def self.extract_controller
    to_s.gsub('Controller', '').downcase
  end

  def self.extract_model
    extract_controller.singularize.camelize.constantize
  end

  def extract_parent_vars
    chain = self.class.extract_model.belongs_chain
    if chain.any?
      root = chain.pop
      parent = root.find(params["#{root.to_s.underscore}_id"])
      instance_variable_set "@#{root.to_s.underscore}", parent
      chain.reverse!.each do |model|
        parent = parent.send(model.to_s.underscore.pluralize).find(params["#{model.to_s.underscore}_id"])
        instance_variable_set "@#{model.to_s.underscore}", parent
      end
    end
  end

  def extract_member_var
    parent = instance_variable_get "@#{(model = self.class.extract_model).belongs_chain.reverse.pop.to_s.underscore}"
    instance_variable_set "@#{model.to_s.underscore}", parent.send(model.to_s.underscore.pluralize).find(params["#{model.to_s.underscore}_id"])
  end

  def extract_collection_var
    parent = instance_variable_get "@#{(model = self.class.extract_model).belongs_chain.reverse.pop.to_s.underscore}"
    instance_variable_set "@#{model.to_s.underscore.pluralize}", parent.send(model.to_s.underscore.pluralize)
  end

  def self.extract_filter action, path, opts
    return if path[0] == '/'
    before_filter :extract_parent_vars, only: action.to_sym
    before_filter :extract_member_var, only: action.to_sym if opts[:on] == 'member'
    before_filter :extract_collection_var, only: action.to_sym if opts[:on] == 'collection'
  end

end

ActiveRecord::Base.send :include, ToyLocomotive::Router::Controller
