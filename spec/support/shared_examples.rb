shared_examples 'distance calculations' do
  let(:google) { [37.422045, -122.084347] }
  let(:haversine) { Arel::Nodes::Haversine.new(*google, *san_francisco, unit: unit) }
  let(:query) { project(haversine.as('distance')).to_sql }
  let(:result) { parse_results(execute(query)) }
  let(:san_francisco) { [37.77493, -122.419416] }

  context 'default unit' do
    let(:unit) { nil }

    it 'returns distance between two coordinates in kilometers' do
      expect(result).to be_within(0.000_001).of(49.103_006)
    end
  end

  context 'in kilometers' do
    let(:unit) { :km }

    it 'returns distance between two coordinates' do
      expect(result).to be_within(0.000_001).of(49.103_006)
    end
  end

  context 'in miles' do
    let(:unit) { :mi }

    it 'returns distance between two coordinates' do
      expect(result).to be_within(0.000_001).of(30.511_148)
    end
  end
end
