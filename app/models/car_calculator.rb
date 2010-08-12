class CarCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include SimpleCalculator
  
  # == Attrs
  attr_accessor :manufacture, :fuel_type, :model, :car, :units, :distance, :units
  
  # == Validations
  validates_presence_of :manufacture
  validates_presence_of :fuel_type
  validates_presence_of :model
  validates_presence_of :car
  validates_presence_of :units
  validates_presence_of :distance
  validates_numericality_of :distance, :allow_blank => true
  validates_inclusion_of :units, :in => %w(emissions_in_kg_per_km emissions_in_kg_per_mile)
  
  def build(*args)
    self
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
  
  # == This is hardcoded why? its never going to change!! which is nice to know!
  #
  # Computations/Calculators can be viwed at 
  #
  # @see http://browser.carboncalculated.com/calculators
  # the actual car computation can be viewed here
  # http://browser.carboncalculated.com/calculators/4c2b11e3ba5e45da86000001/computations/4c2b11f2ba5e45da86000002
  # What we can see is that we have to provied certain details
  #
  # car	=> We must supply a car objects ID
  #
  # distance => Must supply a number
  #
  # formula_input_name => One of the car object formula inputs names; and its also has to be either
  # 'emissions_in_kg_per_km', 'emissions_in_kg_per_mile'
  def self.computation_id
    "4c2b11f2ba5e45da86000002"
  end
  
  # what we need here is a list of manufactors!!
  # Therefore we need to go to 
  # http://browser.carboncalculated.com/object_templates/car/relatable_categories?related_attribute=manufacturer
  # we can see how many manufactures there are currently; so we need to ask the API to give us the manufactors
  # We need to use @session.relatable_categories_for_object_template("car", "manufacturer", :per_page => 60)
  #
  # @return [Array<Calculated::Models::RelatableCategory>] manufactor relatable categories using carboncalculated API
  def self.manufacturers
    CarApp.calculated_session.relatable_categories_for_object_template("car", "manufacturer", :per_page => 60).relatable_categories.sort_by(&:name)
  end
    
end