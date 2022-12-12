# frozen_string_literal: true

[
  { email: 'admin@qotofey.ru', password: 'TMP1q2w3e4r5t6y7', name: 'Admin' }
].each do |user_attributes|
  User.find_or_create_by!(email: user_attributes[:email]) do |user|
    user.attributes = user_attributes
  end
end
