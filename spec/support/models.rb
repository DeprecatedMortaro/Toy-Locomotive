class Dog < ActiveRecord::Base
  belongs_to :human
end

class Human < ActiveRecord::Base
  belongs_to :alien
  has_many :dogs
end

class Alien < ActiveRecord::Base
  has_many :humans
end

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'Human', 'Humans'
end
