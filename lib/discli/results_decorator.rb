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

    def to_s
      results.map do |result|
        "%s | %s | %s" % [
          result['id'].to_s.rjust(9),
          color_type(result['type']).ljust(16),
          result['title']]
      end.join("\n")
    end

    private

    def color_type(type)
      color = {
        'release' => :red,
        'master'  => :green,
        'artist'  => :blue,
        'label'   => :yellow
      }.fetch(type.strip, :black)

      send(color, type)
    end

    def red(text);    colorize(text, 32); end
    def blue(text);   colorize(text, 34); end
    def green(text);  colorize(text, 31); end
    def black(text);  colorize(text, 00); end
    def yellow(text); colorize(text, 33); end

    def colorize(text, code)
      "\e[#{code}m#{text}\e[0m"
    end
  end
end
