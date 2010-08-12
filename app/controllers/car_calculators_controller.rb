class CarCalculatorsController < ApplicationController
  
  def new
    @car_calculator = CarCalculator.new
  end
  
  def create
    @car_calculator = CarCalculator.new(params[:car_calculator])
    @car_calculator.answer_params = params[:car_calculator]
    if @car_calculator.valid?
      @car_calculator.result = get_answer(CarCalculator.computation_id, @car_calculator.answer_params)
      # you want to check for errors from the api here!
      # if the errors exist then you need to handle that accordingly
    end
    if @car_calculator.valid?
      render :create
    else
      render :new
    end
  end
  
  # we get the fuel_types for a particular manufacture
  # the results are in a hash which we turn into an array with
  # key options for JSON
  def get_fuel_types
    relatable_category_id = params[:car_calculator][:manufacture]
    result = CarApp.calculated_session.related_categories_from_relatable_category(relatable_category_id, "fuel_type") 
    final_result = []
    result = result.each_pair do |key, value| 
      final_result << {:name => value, :value => key}
    end
    render :json => {:options => final_result}.to_json
  end
  
  
  # we get the modes for a particular manufacture and fuel_type
  # the results are in a hash which we turn into an array with
  # key options for JSON
  def get_models
    relatable_category_id = params[:car_calculator][:fuel_type]
    relatable_category_ids =  params[:car_calculator][:relatable_category_ids]
    result = CarApp.calculated_session.related_categories_from_relatable_category(relatable_category_id, "model", :relatable_category_ids => relatable_category_ids) 
    final_result = []
    result = (result || []).each_pair do |key, value| 
      final_result << {:name => value, :value => key}
    end
    render :json => {:options => final_result}.to_json
  end
  
  
  # we get the cars from the previous entries of relatable categories
  # ie the manufacture & fuel_type & model
  # the results are in a hash which we turn into an array with
  # key options for JSON
  def get_cars
    relatable_category_ids =  params[:car_calculator][:relatable_category_ids]
    relatable_category_ids << params[:car_calculator][:model]
    result = CarApp.calculated_session.related_objects_from_relatable_categories("car", relatable_category_ids) 
    final_result = []
    result = (result || []).each_pair do |key, value| 
      final_result << {:name => value, :value => key}
    end
    render :json => {:options => final_result}.to_json
  end
  
  private  
  # @param [String] computation_id
  # @param [Hash] params
  #
  # @return [Calculated::Models::Answer]
  def get_answer(computation_id, params)
    params.merge!(:formula_input_name => params[:units])
    CarApp.calculated_session.answer_for_computation(computation_id, params)
  end
end