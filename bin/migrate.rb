#!/bin/env ruby

require_relative '../config/environment'

ActiveRecord::Migration.verbose = true
ActiveRecord::Migrator.migrate File.dirname(__FILE__) + '/../db/migrate/'
