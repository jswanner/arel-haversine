require 'spec_helper'

describe 'Haversine in PostgreSQL', :postgres do
  def parse_results results
    results.first['distance'].to_f
  end

  include_examples 'distance calculations'
end
