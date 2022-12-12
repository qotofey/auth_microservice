# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV.fetch('RACK_ENV', nil))

require_relative 'initializer'
Initializer.run!
