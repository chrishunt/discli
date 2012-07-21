require 'discli'

describe Discli::Client do
  let(:client) { Discli::Client.new }

  it 'searches for single terms' do
    results = client.search('miles davis')
    results.count.should > 0
  end

  it 'can filter by title and year' do
    title = 'kind of blue'
    year  = '2010'

    results = client.search(:year => year, :release_title => title)

    results.count.should > 0
    results.map { |r| r['title'].downcase.should include(title) }
    results.map { |r| r['year'] }.uniq.should == [year]
  end
end
