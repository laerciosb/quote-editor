# frozen_string_literal: true

# To avoid that repetitive work when generating the migrations, the UUID will be used as a primary key by default.
# `foreign_key_type` is still an issue, see https://github.com/rails/rails/issues/23422#issuecomment-695762720
# use `type: :uuid` for references
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end
