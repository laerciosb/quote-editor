# frozen_string_literal: true

require 'simplecov'
require 'simplecov_json_formatter'

SimpleCov.minimum_coverage 80
SimpleCov.minimum_coverage_by_file 60
SimpleCov.configure do
  formatter SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::JSONFormatter
    ]
  )

  coverage_dir(ENV['COVERAGE_REPORTS'] || 'coverage')
  add_group('Interactions', 'app/interactions')
  add_group('Services', 'app/services')
  add_group('Serializers', 'app/serializers')
  add_filter(/application_/)
  add_filter(/base_/)
  add_filter(/vendor/)
end
