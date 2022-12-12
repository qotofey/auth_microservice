# frozen_string_literal: true

module ErrorSerializer
  extend self

  def from_messages(error_messages, meta: {})
    error_messages = Array(error_messages)
    { errors: build_errors(error_messages, meta) }
  end
  alias from_message from_messages

  def from_model(model)
    { errors: build_model_errors(model.errors) }
  end

  def from_contract(contract)
    { errors: build_contract_errors(contract.errors) }
  end

  private

  def build_errors(error_messages, meta)
    error_messages.map { |message| build_error(message, meta) }
  end

  def build_model_errors(errors)
    errors.map do |key, messages|
      messages.map do |message|
        error = build_error(message)
        error[:source] = { pointer: "/data/attributes/#{key}" }
        error
      end
    end.flatten
  end

  def build_contract_errors(errors)
    errors.map do |message|
      error = build_error(message.text)
      error[:source] = { pointer: "/#{message.path.join('/')}" }
      error
    end
  end

  def build_error(message, meta = {})
    error = { detail: message }
    error[:meta] = meta if meta.present?
    error
  end
end
