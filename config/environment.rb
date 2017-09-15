require 'active_record'

# recursively requires all models
Dir.glob('./models/*.rb').each do |file|
  require file
end

# tells AR what db file to use
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/store.sqlite3'
)
