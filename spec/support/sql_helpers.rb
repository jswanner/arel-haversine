def execute query
  ActiveRecord::Base.connection.execute query
end

def project clause
  Arel::SelectManager.new(ActiveRecord::Base).project clause
end
