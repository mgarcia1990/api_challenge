FactoryBot.define do
  factory :authentication_token do
    body "MyString"
    user nil
    last_used_at "2018-11-05 11:27:49"
    expires_in 1
    ip_address "MyString"
    user_agent "MyString"
  end
end
