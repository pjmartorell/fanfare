if ENV['HEROKU'].present?
  keys = [:name,
          :hostname,
          :exception_notification_sender,
          :exception_notification_recipient,
          :mail__user_name,
          :mail__password,
          :mail__smtp__address,
          :mail__smtp__port,
          :mail__domain,
          :storage,
          :storage__s3_access,
          :storage__s3_secret,
          :mailchimp_key,
          :paypal__account
         ]

  APP_CONFIG = HashWithIndifferentAccess.new

  keys.each do |key|
    APP_CONFIG[key.to_s.split("__").join(".")] = ENV[key.to_s.upcase]
  end

else
  APP_CONFIG = Hashie::Mash.new(YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env])
end