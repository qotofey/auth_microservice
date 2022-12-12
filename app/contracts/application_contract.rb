# frozen_string_literal: true

class ApplicationContract < ::Dry::Validation::Contract
  config.messages.backend = :i18n

  EMAIL_FORMAT_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  register_macro(:email_format) do
    key.failure(':invalid') unless EMAIL_FORMAT_REGEXP.match?(value)
  end
end
