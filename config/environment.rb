# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
path = Rails.root.join('config/mongoid.yml')
puts path
environment = defined?(Rails) && Rails.respond_to?(:env) ? Rails.env : ENV["RACK_ENV"]
settings = YAML.load(ERB.new(File.new(path).read).result)[environment]
puts settings.to_yaml
puts ENV.keys.to_yaml
DatagridDemo::Application.initialize!
