$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
require 'arel/haversine'
require 'active_record'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'
end

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |file| require file }
