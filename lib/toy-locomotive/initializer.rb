module ToyLocomotive

  def self.initialize!
    initialize_models!
    initialize_routes!
  end

  def self.initialize_models!
    Dir["#{Rails.root}/app/models/*.rb"].each {|file| require file}
  end

  def self.initialize_routes!
    Dir["#{Rails.root}/app/controllers/*.rb"].each {|file| require file}
    Rails.application.class::Application.routes.draw do
      ToyLocomotive.routes.each {|route| match route[:path] => "#{route[:controller]}##{route[:action]}", as: route[:as], via: route[:method]}
    end
  end

end
