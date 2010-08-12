module CarbonCalculatedApi
  class GenericObjectApp < API::App
    
    get '/generic_objects.json' do  
      if @per_page.to_i == 5
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "generic_objects_per_page_5.json"))        
      else
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "generic_objects.json"))
      end
    end
        
    get "/generic_objects/:id.json" do |id|
      begin
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "generic_object_#{id}.json"))
      rescue
        raise Sinatra::NotFound
      end
    end
  
    get "/generic_objects/:id/formula_inputs.json" do |id|
      begin
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "formula_inputs_#{id}.json"))
      rescue
        raise Sinatra::NotFound
      end
    end
    
  end
end
