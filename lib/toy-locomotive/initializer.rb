module ToyLocomotive
  class Engine < Rails::Engine
    initializer 'toy_locomotive.initialize', :after => :disable_dependency_loading do |app|
      Dir["#{Rails.root}/app/models/*.rb"].each do |file|
        require file
        AttributeObserver.new file.split('/').last.split('.').first.classify.constantize
      end
      controllers = []
      Dir["#{Rails.root}/app/controllers/*.rb"].each do |file|
        require file
        controllers << file.split('/').last.split('.').first.classify.constantize
        controllers.last.append_filters!
      end
      Rails.application.class.routes.draw do
        controllers.each {|controller| controller.draws.each {|draw| send *draw}}
        ToyLocomotive.routes.each {|route| match route[:path] => "#{route[:controller]}##{route[:action]}", as: route[:as], via: route[:method]}
      end
    end
  end
end
