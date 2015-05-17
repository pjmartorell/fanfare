if ENV['HEROKU'].present?
  yaml_data = YAML.load_file("#{Rails.root}/config/app.yml")
  APP_CONFIG = HashWithIndifferentAccess.new(yaml_data)

else
  APP_CONFIG = Hashie::Mash.new(YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env])
end