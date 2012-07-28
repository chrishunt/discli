module Discli
  class ResultsDecorator
    attr_reader :results

    def initialize(results)
      @results = results
    end

    def filter(params)
      params.inject(results) do |filtered_results, (param, value)|
        param, value = param.downcase.to_s, value.downcase.to_s

        filtered_results.select do |result|
          values = result[param]
          if values.respond_to?(:map)
            values.map(&:downcase).map(&:split).flatten.include?(value)
          elsif values
            values.downcase == value
          end
        end
      end
    end
  end
end
