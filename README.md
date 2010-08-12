#Car Calculator Example#

This is a simple car journey calculator using the [calculated gem](http://github.com/hookercookerman/calculated), provided By [Carbon Calculated](http://www.carboncalculated.com)
it asks the user enter details about their car to then find a specific car; the user is then asks to enter a distance; The CO2 emissions
of the journey is then calculated; Super simple basically.

This an example of a rails3 application using the carboncalculated api; 
documentation for the api can be found [here](http://www.carboncalculated.com/platform/api/docs)

##Getting the Application Up and Running##

1. Get an api key from the guys are carboncalculated.com email support@carboncalculated.com and ask for one
2. install bundler version 1.0.0.rc.5
3. bundle install
4. set you api key in the yaml file confg/car_app.yml api_key:
5. script/rails server
4. enjoy

Have a good look around and see how it was constructed it may give you ideas on how to create your own application using the 
carboncalculated api.....

##Specs##
bundle exec spec

##Features##
bundle exec cucumber

Have any question don't hesitate to contact support@carboncalculated.com

Licensing so the LICENCE file;