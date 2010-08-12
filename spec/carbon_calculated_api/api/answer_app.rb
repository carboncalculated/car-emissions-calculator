module CarbonCalculatedApi
  class AnswerApp < API::App
        
    error 500 do
      {:errors => {:base => request.env['sinatra.error'].message}}.to_json
    end

    get "/computations/:computation_id/answer.json" do |computation_id|
      File.read(File.join(File.dirname(__FILE__), "..", "responses", "answer_for_car.json"))
    end
  
  end
end
