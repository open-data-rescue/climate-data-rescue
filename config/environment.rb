# Load the rails application
require File.expand_path('../application', __FILE__)

Weather::Application.configure do 
	config.time_zone = "Eastern Time (US & Canada)"
end

# Initialize the rails application
Rails.application.initialize!
