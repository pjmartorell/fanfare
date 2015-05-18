# Load the Rails application.
require File.expand_path('../application', __FILE__)

require "#{Rails.root}/config/setup_app"

# Initialize the Rails application.
Fanfare::Application.initialize!
