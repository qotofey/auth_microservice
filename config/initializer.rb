# frozen_string_literal: true

require_relative 'application'

module Initializer
  extend self

  def run!
    initialize_config
    initialize_database
    initialize_application
  end

  def root_path
    @root_path ||= File.expand_path('..', __dir__)
  end

  private

  def initialize_config
    require_file('config/initializers/config')
  end

  def initialize_database
    require_file('config/initializers/sequel')
  end

  def initialize_application
    require_dir('app/helpers')
    require_file('config/application')
    require_file('app/services/basic_service')
    require_dir 'app/contracts'
    # require_dir 'app/responses'
    require_dir('app')
    require_dir('config/initializers')
  end

  def require_file(path)
    require File.join(root_path, path)
  end

  def require_dir(path)
    path = File.join(root_path, path)

    Dir["#{path}/**/*.rb"].sort.each { |file| require file }
  end
end
