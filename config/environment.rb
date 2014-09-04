# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load APP configuration
APP_CONFIG = Hashie::Mash.new(YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env])

# Initialize the Rails application.
Fanfare::Application.initialize!
