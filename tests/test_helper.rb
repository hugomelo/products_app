require 'test/unit'
require_relative '../config/environment'

class Test::Unit::TestCase

  def setup_database
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'db/store_test.sqlite3'
    )
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate File.dirname(__FILE__) + '/../db/migrate/'
    Product.destroy_all
  end
end
