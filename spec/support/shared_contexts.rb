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
