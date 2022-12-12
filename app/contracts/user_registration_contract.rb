# frozen_string_literal: true

class UserRegistrationContract < ApplicationContract
  params do
    required(:name).filled(:string, min_size?: 2)
    required(:email).filled(:string)
    required(:password).filled(:string, min_size?: 8)
    required(:confirmed_password).filled(:string)
  end

  rule(:email).validate(:email_format)
  rule(:confirmed_password, :password) do
    key.failure('пароли не совпадают') if values[:confirmed_password] != values[:password]
  end
end
