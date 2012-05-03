module ToyLocomotive
  def self.initialize!
    Dir["#{Rails.root}/app/controllers/*.rb"].each {|file| require file}
    Rails.application.class::Application.routes.draw do
      ToyLocomotive.routes.each {|route| match route[:path] => "#{route[:controller]}##{route[:action]}", as: route[:as], via: route[:method]}
    end
  end
end
