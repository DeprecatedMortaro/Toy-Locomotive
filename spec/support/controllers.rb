class DogsController < ActionController::Base

  def params
    {alien_id: Alien.first.id, human_id: Human.first.id, dog_id: Dog.first.id}
  end

  get '/absolute' do
    'absolute route'
  end

  get 'member', on: 'member' do
    'member route'
  end

  get 'collection', on: 'collection' do
    'collection route'
  end

end
DogsController.append_filters!

class HumansController < ActionController::Base

end
HumansController.append_filters!

class AliensController < ActionController::Base

end
AliensController.append_filters!
