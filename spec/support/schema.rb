ActiveRecord::Schema.define do

  self.verbose = false

  create_table :dogs, :force => true do |t|
    t.integer :human_id
    t.timestamps
  end

  create_table :humans, :force => true do |t|
    t.integer :alien_id
    t.timestamps
  end

  create_table :aliens, :force => true do |t|
    t.timestamps
  end

end
