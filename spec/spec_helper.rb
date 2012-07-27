require 'toy-locomotive'
require 'rspec-rails'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: './toy_locomotive.sqlite3')

%w(schema models seeds controllers).each { |file| load "#{File.dirname(__FILE__)}/support/#{file}.rb" }
