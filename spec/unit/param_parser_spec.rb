require 'discli/param_parser'

describe Discli::ParamParser do
  let(:subject) { Discli::ParamParser }

  describe '#to_params' do
    it 'parses single search term command line arguments' do
      argv = ['Miles Davis']
      subject.new(argv).to_params.should == 'Miles Davis'
    end

    it 'parses parameterized command line arguments' do
      argv = ['--year', '2010', '--release-title', 'kind of blue']

      subject.new(argv).to_params.should == {
        :year          => '2010',
        :release_title => 'kind of blue' }
    end
  end

  it 'raises an exception with zero parameters' do
    argv = []

    lambda { subject.new(argv).to_params }.should raise_error(
      Discli::ParamParser::InvalidParamCount )
  end

  it 'raises an exception for incorrect number of parameters' do
    argv = ['--year', '2010', '--title']

    lambda { subject.new(argv).to_params }.should raise_error(
      Discli::ParamParser::InvalidParamCount )
  end

  it 'raises an exception for invalid parameters' do
    argv = ['--color', 'red']

    lambda { subject.new(argv).to_params }.should raise_error(
      Discli::ParamParser::InvalidParam )
  end
end
