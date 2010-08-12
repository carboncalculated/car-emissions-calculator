# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


lib_dir = ::File.expand_path(::File.join(::File.dirname(__FILE__)))
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', 'version_mapper')
require ::File.join(lib_dir, 'carbon_calculated_api', 'api')
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "generic_object_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "object_template_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "answer_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "relatable_category_app")

# == Remarkable activeModel Yes please
require 'remarkable/active_model'

RSpec.configure do |config|
  config.before(:each) do
    # set up the api
    @api_user = ApiUser.new(:email => "helptheplanet@cc.com", :api_key => "testing_api_key")
  
    ApiUser.record(@api_user)
    Artifice.activate_with(CarbonCalculatedApi::API.app)
  end

  config.after(:each) do
    Artifice.deactivate
  end
 
  config.mock_with :rspec
end
