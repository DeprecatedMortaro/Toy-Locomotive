class Dog < ActiveRecord::Base
  belongs_to :human
end

class Human < ActiveRecord::Base
  belongs_to :alien
end

class Alien < ActiveRecord::Base
end
