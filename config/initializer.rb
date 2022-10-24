# frozen_string_literal: true

require_relative 'application'

module Initializer
  extend self

  def run!
    initialize_application
  end

  private

  def initialize_application
    # require_relative 'initializer/i18n'

  end
end
