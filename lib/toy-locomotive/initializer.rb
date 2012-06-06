module ToyLocomotive
  class Engine < Rails::Engine
    initializer 'toy_locomotive.initialize', :after=> :disable_dependency_loading do |app|
      Dir["#{Rails.root}/app/models/*.rb"].each do |file|
        require file
        AttributeObserver.new file.split('/').last.split('.').first.classify.constantize
      end
      Dir["#{Rails.root}/app/controllers/*.rb"].each do |file|
        require file
        const = file.split('/').last.split('.').first.classify.constantize.append_filters!
      end
      Rails.application.class.routes.draw do
        ToyLocomotive.routes.each {|route| match route[:path] => "#{route[:controller]}##{route[:action]}", as: route[:as], via: route[:method]}
      end
    end
  end
end
