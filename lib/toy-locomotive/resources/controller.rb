module ToyLocomotive::Resources::Controller

  module ClassMethods
    def extract_resources args
      actions = [:index, :new, :create, :show, :edit, :update, :destroy]
      return actions if args == :all
      return args[:only] if args[:only]
      actions - args[:except]
    end

    def resources args
      extract_resources(args).each{|action| send :"set_action_#{action}"}
    end

    def set_action_new
      get 'new' do
        extract_parent_vars
        parent = instance_variable_get (model = self.class.extract_model).belongs_chain.reverse.pop.to_member_var
        instance_variable_set model.to_member_var, (parent ? parent.send(model.to_s.underscore.pluralize) : model).new
      end
    end

    def set_action_index
      get 'index' do
        extract_parent_vars
        extract_collection_var
      end
    end

    def set_action_show
      get 'show' do
        extract_parent_vars
        extract_member_var
      end
    end

    def set_action_edit
      get 'edit' do
        extract_parent_vars
        extract_member_var
      end
    end

    def set_action_create
      post 'create' do
        extract_parent_vars
        parent = instance_variable_get (model = self.class.extract_model).belongs_chain.reverse.pop.to_member_var
        member = (parent ? parent.send(model.to_s.underscore.pluralize) : model).new(params[model.to_params])
        instance_variable_set model.to_member_var, member
        return redirect_to member, notice: 'Burrito was successfully created.' if member.save
        render action: 'new'
      end
    end

    def set_action_update
      put 'update' do
        extract_parent_vars
        member = extract_member_var
        return redirect_to member, notice: 'Burrito was successfully updated.' if member.update_attributes(params[member.class.to_s.underscore.to_sym])
        render action: 'edit'
      end
    end

    def set_action_destroy

    end

  end

end
ActionController::Base.extend ToyLocomotive::Resources::Controller::ClassMethods
