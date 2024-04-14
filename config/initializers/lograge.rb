# frozen_string_literal: true

LOGGER_CUSTOM_HEADERS = ENV['LOGGER_CUSTOM_HEADERS'].presence&.split || []
LOGGER_ENABLED_HEADERS = (%w[HTTP_X_REQUEST_ID] + LOGGER_CUSTOM_HEADERS).freeze
LOGGER_IGNORE_PARAMS = %w[controller action format id].freeze

Rails.application.configure do
  config.lograge.enabled = ActiveRecord::Type::Boolean.new.cast(ENV['LOGRAGE_ENABLED']) || false
  config.lograge.base_controller_class = %w[ActionController::Base]
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.custom_payload do |controller|
    {
      request_id: controller.request.request_id,
      trace_id: (OpenTelemetry::Trace.current_span.context.hex_trace_id if Constant::OTEL_INSTRUMENTATION_ENABLED),
      host: controller.request.host,
      ip: controller.request.ip,
      user_agent: controller.request.user_agent,
      headers: controller.request.headers.env.slice(*LOGGER_ENABLED_HEADERS).presence,
      user_id: (controller.current_user&.id if controller.respond_to?(:current_user))
    }.compact
  end
  config.lograge.custom_options = lambda do |event|
    {
      params: event.payload[:params].presence&.except(*LOGGER_IGNORE_PARAMS),
      exception: event.payload[:exception],
      exception_object: event.payload[:exception_object]
    }.compact
  end
end
