module Discli
  class ParamParser
    class InvalidParamCount < StandardError; end
    class InvalidParam < StandardError; end

    attr_reader :argv

    VALID_PARAMS = {
      :artist        => 'Search artist names',
      :release_title => 'Search release titles',
      :label         => 'Search label names',
      :title         => 'Search combined "Artist - Release Title" field',
      :catno         => 'Search catalog numbers',
      :barcode       => 'Search barcodes',
      :year          => 'Search by year' }

    def self.usage
      VALID_PARAMS.map do |param, description|
        "#{('--' + param.to_s).rjust(15)}  #{description}"
      end.join("\n")
    end

    def initialize(argv)
      @argv = argv
    end

    def to_params
      if argv.size == 1
        argv.first
      elsif argv.size == 0 || argv.size % 2 == 1
        raise InvalidParamCount.new('Invalid number of parameters')
      else
        parsed_params
      end
    end

    private

    def parsed_params
      argv.each_slice(2).inject({}) do |params, param_set|
        param = parse_param(param_set[0])
        term  = param_set[1]
        params.merge(param => term)
      end
    end

    def parse_param(param)
      parsed_param = param.gsub('--', '').gsub('-', '_').to_sym

      if VALID_PARAMS.include?(parsed_param)
        return parsed_param
      else
        raise InvalidParam.new("Invalid parameter: #{param}")
      end
    end
  end
end
