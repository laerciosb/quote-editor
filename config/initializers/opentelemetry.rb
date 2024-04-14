# frozen_string_literal: true

return unless Constant::OTEL_INSTRUMENTATION_ENABLED

OTL_OPTS = {
  'OpenTelemetry::Instrumentation::PG' => { peer_service: 'main', db_statement: :obfuscate },
  'OpenTelemetry::Instrumentation::Rack' => { untraced_endpoints: %w[/api/v1/healthcheck] }
}.freeze

RESOURCE_OPTS = { 'service.instance.id' => Socket.gethostname }.freeze

# Exporter and Processor configuration
exporter = OpenTelemetry::Exporter::OTLP::Exporter.new
processor = OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(exporter)

OpenTelemetry::SDK.configure do |cfg|
  cfg.service_name = ENV.fetch('OTEL_SERVICE_NAME') { 'quote_editor_development' }
  cfg.service_version = '0.0.1'

  # Exporter and Processor configuration
  cfg.add_span_processor(processor) # Created above this SDK.configure block

  # Resource configuration
  cfg.resource = OpenTelemetry::SDK::Resources::Resource.create(RESOURCE_OPTS)

  cfg.use_all(OTL_OPTS)
end
