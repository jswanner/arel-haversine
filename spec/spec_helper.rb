$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
require 'arel/haversine'
require 'active_record'
require 'mysql2'
require 'pg'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'
end

shared_examples 'distance calculations' do
  it 'returns distance between two coordinates in kilometer' do
    haversine = Arel::Nodes::Haversine.new(37.422045, -122.084347, 37.77493, -122.419416)
    query = 'SELECT %s AS distance;' % haversine.to_sql
    result = parse_results(execute(query))
    expect(result).to be_within(0.000_001).of(49.103_006)
  end

  it 'returns distance between two coordinates in miles' do
    haversine = Arel::Nodes::Haversine.new(37.422045, -122.084347, 37.77493, -122.419416, unit: :mi)
    query = 'SELECT %s AS distance;' % haversine.to_sql
    result = parse_results(execute(query))
    expect(result).to be_within(0.000_001).of(30.511_148)
  end
end

shared_context 'MySQL connection', :mysql do
  before :all do
    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      database: 'arel_haversine_test'
    )
  end
end

shared_context 'Postgres connection', :postgres do
  before :all do
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      database: 'arel_haversine_test'
    )
  end
end

def execute query
  ActiveRecord::Base.connection.execute query
end
