module ToyLocomotive::Resources::Controller

  module ClassMethods
    def extract_resources args
      actions = {}
      crud = [:index, :new, :create, :show, :edit, :update, :destroy]
      if args.first == :all
        actions[:crud] = crud
        hash = args.last
      else
        hash = args
      end
      #actions[:crud] = hash[:only] if hash[:only]
      #actions[:crud] = crud - hash[:except] if hash[:except]
      #actions[:member] = hash[:member]
      #actions[:collection] = hash[:collection]
      #actions[:static] = hash[:static]
      actions
    end

    def resources *args
      res = extract_resources(args)
      res[:crud].each{|action| send :"set_action_#{action}"} if res[:crud]
      res[:member].each{|action| set_member_action(action)} if res[:member]
      res[:collection].each{|action| set_collection_action(action)} if res[:collection]
      res[:static].each{|action| set_static_action(action)} if res[:static]
    end

    def set_static_action action
      get action.to_s do end
    end

    def set_member_action action
      get action.to_s, on: 'member' do end
    end

    def set_collection_action action
      get action.to_s, on: 'collection' do end
    end

    def set_action_new
      get 'new' do
        parent = extract_parent_vars.last
        model = self.class.extract_model
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
        parent = (vars = extract_parent_vars).last
        model = self.class.extract_model
        member = (parent ? parent.send(model.to_s.underscore.pluralize) : model).new(params[model.to_s.underscore.to_sym])
        instance_variable_set model.to_member_var, member
        vars = vars << member
        return redirect_to vars, notice: 'Burrito was successfully created.' if member.save
        render action: 'new'
      end
    end

    def set_action_update
      put 'update' do
        vars = extract_parent_vars
        vars = vars << (member = extract_member_var)
        return redirect_to vars, notice: 'Burrito was successfully updated.' if member.update_attributes(params[member.class.to_s.underscore.to_sym])
        render action: 'edit'
      end
    end

    def set_action_destroy
      delete 'destroy' do
        vars = extract_parent_vars
        extract_member_var.destroy
        redirect_to action: :index, notice: 'Burrito was successfully deleted'
      end
    end

  end

end
ActionController::Base.extend ToyLocomotive::Resources::Controller::ClassMethods
