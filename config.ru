# frozen_string_literal: true

require_relative 'config/environment'

run Application.freeze.app

# class App
#   def self.call(env)
#     # byebug
#     # response = User::AuthenticationResponse.new
#     # [response.status, response.headers, response.body]
#     response = Rack::Response.new
#     response.content_type = 'application/json'
#
#     # response.set_header('Accept', 'application/json')
#     response.status = 200
#     response.write('{}')
#     byebug
#     response.finish
#   end
# end
#
# run App