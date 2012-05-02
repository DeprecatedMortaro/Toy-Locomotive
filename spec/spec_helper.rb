require 'toy-locomotive'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: './toy_locomotive.sqlite3')

%w(schema models seeds).each { |file| load "#{File.dirname(__FILE__)}/support/#{file}.rb" }
