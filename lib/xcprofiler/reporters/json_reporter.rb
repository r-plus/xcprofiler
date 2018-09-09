require 'json'

module Xcprofiler
  class JSONReporter < AbstractReporter
    def report!(executions)
      json = executions.map(&:to_h)
      unless output
        raise OutputPathIsNotSpecified, '[JSONReporter] output is not specified'
      end

      File.open(output, "w") do |f|
        f.write(JSON.pretty_generate(json))
      end
    end

    private

    def output
      options[:output]
    end
  end
end
