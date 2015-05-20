# Load the Rails application.
require File.expand_path('../application', __FILE__)

require "#{Rails.root}/config/setup_app"

Rails.logger = Le.new(APP_CONFIG['logentries'], :debug => true, :local => true)

# Initialize the Rails application.
Fanfare::Application.initialize!
