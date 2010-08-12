Given /^I am an anonymous user$/ do
  # should be true
end

When /^I select manufacture: (.*)$/ do |manufacture|
  When("I select \"#{manufacture}\" from \"car_calculator_manufacture\"")
end

When /^I select fuel_type: (.*)$/ do |fuel|
  When("I select \"#{fuel}\" from \"car_calculator_fuel_type\"")
end

When /^I select model: (.*)$/ do |model|
  When("I select \"#{model}\" from \"car_calculator_model\"")
end

When /^I select car: (.*)$/ do |car|
  When("I select \"#{car}\" from \"car_calculator_car\"")
end

When /^I enter a distance of (\d+)$/ do |distance|
  When("I fill in \"car_calculator_distance\" with \"#{distance}\"")
end