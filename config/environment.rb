# Load the Rails application.
require_relative 'application'
Rails.application.routes.default_url_options[:host] = ENV['APIHOST'].nil? ? "192.168.0.151:3000" : ENV['APIHOST']

# Initialize the Rails application.
Rails.application.initialize!
