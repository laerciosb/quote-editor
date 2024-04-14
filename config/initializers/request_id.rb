# frozen_string_literal: true

# https://github.com/open-telemetry/opentelemetry-ruby-contrib/issues/126
# https://github.com/open-telemetry/opentelemetry-ruby-contrib/pull/162
# https://github.com/open-telemetry/opentelemetry-ruby-contrib/blob/main/instrumentation/action_pack/lib/opentelemetry/instrumentation/action_pack/patches/action_controller/metal.rb
# https://github.com/rails/rails/blob/main/actionpack/lib/action_dispatch/middleware/request_id.rb
module ActionDispatch
  class RequestId
    EDGE_REQUEST_ID = 'X-Azn-Request-Id'
    OTEL_REQUEST_ID = 'http.request.header.x_request_id'

    def initialize(app, header:)
      @app = app
      @header = header
    end

    def call(env)
      req = ActionDispatch::Request.new(env)
      req.request_id = make_request_id(req.headers[@header].presence || req.headers[EDGE_REQUEST_ID].presence)
      request_custom_settings(req.request_id)

      @app.call(env).tap { |_status, headers, _body| headers[@header] = req.request_id }
    end

    private

    def request_custom_settings(request_id)
      Current.request_id = request_id
      return unless Constant::OTEL_INSTRUMENTATION_ENABLED

      OpenTelemetry::Instrumentation::Rack.current_span.set_attribute(OTEL_REQUEST_ID, request_id)
    end

    def make_request_id(request_id)
      if request_id.presence
        request_id.gsub(/[^\w\-@]/, '').first(255)
      else
        internal_request_id
      end
    end

    def internal_request_id
      SecureRandom.uuid
    end
  end
end
