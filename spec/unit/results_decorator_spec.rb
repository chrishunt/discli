require 'discli/results_decorator'

describe Discli::ResultsDecorator do
  let(:subject) { Discli::ResultsDecorator.new(results) }
  let(:results) { eval(File.read('spec/fixtures/results.rb')) }

  describe '#filter' do
    it 'can filter by result type' do
      results = subject.filter(:type => 'release')
      results.count.should == 3
      results.map { |r| r['type'] }.uniq.should == ['release']
    end

    it 'can filter by result format' do
      results = subject.filter(:format => 'vinyl')
      results.count.should == 2
      results.each { |r| r['format'].map(&:downcase).should include('vinyl') }
    end

    it 'can filter by result genre' do
      results = subject.filter(:genre => 'funk')
      results.count.should == 2
      results.each do |result|
        genres = result['genre'].map(&:downcase).map(&:split).flatten
        genres.should include('funk')
      end
    end

    it 'can filter by multiple parameters' do
      results = subject.filter(:year => '2003', :genre => 'funk')
      results.count.should == 1
      results.first['title'].should == "Makin' Time"
    end
  end
end
