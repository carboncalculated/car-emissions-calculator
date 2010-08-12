require "bundler"
Bundler.setup

# get the calculated gem and bundle in the test group
require "calculated"
Bundler.require(:test)

# support ::Files
lib_dir = ::File.expand_path(::File.join(::File.dirname(__FILE__)))
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', 'version_mapper')
require ::File.join(lib_dir, 'carbon_calculated_api', 'api')
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "generic_object_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "object_template_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "answer_app")
require ::File.join(lib_dir, 'carbon_calculated_api', 'api', "relatable_category_app")

run CarbonCalculatedApi::API.app