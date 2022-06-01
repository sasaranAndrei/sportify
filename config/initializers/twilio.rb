Twilio.configure do |config|
  config.account_sid = Rails.application.credentials.dig(:twilio, :account_sid)
  config.auth_token = Rails.application.credentials.dig(:twilio, :auth_token)
end

# nu pot trimite SMS-uri in Romania, numa call-uri
# client call:

# Twilio::REST::Client.new.calls.create(
#   from: '+40744178201',
#   to: '+40741518115',
#   url: 'http://example.com'
# )
