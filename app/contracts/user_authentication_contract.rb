# frozen_string_literal: true

class UserAuthenticationContract < ApplicationContract
  params do
    required(:email).filled(:string)
    required(:password).filled(:string, min_size?: 8)
  end

  rule('email').validate(:email_format)
end
