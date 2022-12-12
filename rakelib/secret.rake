# frozen_string_literal: true

desc 'Run secret generation'
task :secret do
  require 'securerandom'

  secret_key_base = SecureRandom.hex(64)
  puts secret_key_base
end
