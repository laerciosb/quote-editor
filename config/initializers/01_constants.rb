# frozen_string_literal: true

# require 'uri'

# type_checker = {
#   uri: URI::DEFAULT_PARSER.make_regexp,
#   email: URI::MailTo::EMAIL_REGEXP,
#   integer: ActiveModel::Validations::NumericalityValidator::INTEGER_REGEX
# }.freeze

# format_checker = lambda do |env_name, validator|
#   return unless type_checker[validator].presence

#   ENV[env_name] if type_checker[validator].match?(ENV[env_name])
# rescue StandardError
#   nil
# end

constants = {
  # APP_KID: ENV['APP_KID'].presence || SecureRandom.uuid,
  # EXTERNAL_SERVICE_BASE_URL: format_checker.call('EXTERNAL_SERVICE_BASE_URL', :uri),
  # EXTERNAL_SERVICE_EXP_TIME_SECONDS: format_checker.call('EXTERNAL_SERVICE_EXP_TIME_SECONDS', :integer)&.to_i,
  # OPENID_RSA_PRIVATE_KEY: ENV['OPENID_RSA_PRIVATE_KEY'],
  OTEL_INSTRUMENTATION_ENABLED: ActiveRecord::Type::Boolean.new.cast(ENV['OTEL_INSTRUMENTATION_ENABLED'])
}

module Constant; end

required = constants.map do |key, value|
  Constant.const_set(key.to_s, value)

  next unless value.to_s.empty?

  key.tap { Rails.logger.info("Required variable: #{key}") }
end

raise 'Constants missing, check config/initializers/01_constants.rb' if !Rails.env.test? && required.any?
