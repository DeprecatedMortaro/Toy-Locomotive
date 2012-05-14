module ToyLocomotive::Router::Controller

  module ClassMethods

    %w(get put post delete).each {|via| eval "def #{via} path, opts={}, &blk; match_action \"#{via}\", path, opts, blk; end"}

    def match_action method, path, opts, blk
      action = extract_action path, opts, method
      extract_filter action, path, opts, method
      as = extract_as path, opts, method
      path = extract_path path, opts
      controller = extract_controller
      add_route method, action, path, as, controller
      define_method action, blk
    end

    def add_route method, action, path, as, controller
      ToyLocomotive.routes ||= []
      ToyLocomotive.routes << {method: method, action: action, path: path, controller: controller, as: as}
      puts ({method: method, action: action, path: path, controller: controller, as: as}.inspect)
    end

    def add_member_filter action
      @member_filters ||= []
      @member_filters << action.to_sym
    end

    def add_collection_filter action
      @collection_filters ||= []
      @collection_filters << action.to_sym
    end

    def extract_path path, opts={}
      return path if path[0] == '/'
      return "#{extract_model.route_chain}#{extract_model.to_route}/#{path.parameterize}" if opts[:on] == 'member' || ['edit','new'].include?(path)
      return "#{extract_model.route_chain}#{extract_model.to_route}" if ['show','update','destroy'].include?(path)
      return "#{extract_model.route_chain}/#{extract_model.to_s.underscore.pluralize}" if ['create', 'index'].include?(path)
      "#{extract_model.route_chain}/#{extract_model.to_s.underscore.pluralize}/#{path.parameterize}"
    end

    def extract_as path, opts={}, method='get'
      return extract_model.to_as.pluralize if path == '' and method == 'get' and opts[:on] == 'collection'
      return extract_model.to_as if path == '' and method == 'get' and opts[:on] == 'member'
      return nil if method != 'get'
      action = extract_action path, opts
      path[0] == '/' ? action : "#{action}_#{extract_model.to_as}"
    end

    def extract_action path, opts={}, method='get'
      #return 'update' if path == '' and method == 'put' and opts[:on] == 'member'
      #return 'create' if path == '' and method == 'post'
      #return 'destroy' if path == '' and method == 'delete'
      (opts[:as] || (path == '/' ? 'root' : path)).parameterize.underscore
    end

    def extract_controller
      to_s.gsub('Controller', '').downcase
    end

    def extract_model
      extract_controller.singularize.camelize.constantize
    end

    def extract_filter action, path, opts, method
      return if path[0] == '/'
      return if %w(index show new edit destroy update create).include? path
      send :"add_#{opts[:on]}_filter", action
    end

    def append_filters!
      before_filter :extract_parent_vars, only: ((@member_filters || []) + (@collection_filters || []))
      before_filter :extract_member_var, only: (@member_filters || [])
      before_filter :extract_collection_var, only: (@collection_filters || [])
    end

  end

  module InstanceMethods

    def extract_parent_vars
      chain = self.class.extract_model.belongs_chain
      vars = []
      if chain.any?
        root = chain.pop
        parent = root.find(params[root.to_params])
        instance_variable_set root.to_member_var, parent
        vars << parent
        chain.reverse!.each do |model|
          parent = parent.send(model.to_s.underscore.pluralize).find(params[model.to_params])
          instance_variable_set model.to_member_var, parent
          vars << parent
        end
      end
      vars
    end

    def extract_member_var
      parent = instance_variable_get (model = self.class.extract_model).belongs_chain.reverse.pop.to_member_var
      parent ? instance_variable_set(model.to_member_var, parent.send(model.to_s.underscore.pluralize).find(params[model.to_params])) : model.find(params[model.to_params])
    end

    def extract_collection_var
      parent = instance_variable_get (model = self.class.extract_model).belongs_chain.reverse.pop.to_member_var
      parent ? instance_variable_set(model.to_collection_var, parent.send(model.to_s.underscore.pluralize)) : model.all
    end

  end

end

ActionController::Base.extend ToyLocomotive::Router::Controller::ClassMethods
ActionController::Base.send :include, ToyLocomotive::Router::Controller::InstanceMethods
