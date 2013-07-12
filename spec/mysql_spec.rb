require 'spec_helper'

describe 'Haversine in MySQL', :mysql do
  def parse_results results
    results.first.first
  end

  include_examples 'distance calculations'
end
