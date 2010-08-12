module CarbonCalculatedApi
  class ObjectTemplateApp < API::App
    
    get "/object_templates.json" do
      if @per_page.to_i == 5
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "object_templates_per_page_5.json"))        
      else
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "object_templates.json"))
      end
    end
    
    get "/object_templates/:name/generic_objects.json" do |name|
      begin
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "object_templates_#{name}_generic_objects.json"))
      rescue
        raise Sinatra::NotFound
      end
    end
    
    get "/object_templates/:name/relatable_categories.json" do |name|
      # mimic the api needing related attribute params
      throw :halt, [412, {:error => "Params: related_attribute was not given"}.to_json] unless params[:related_attribute]      
      begin
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "object_templates_#{name}_related_categories_#{params[:related_attribute]}.json"))
      rescue
        raise Sinatra::NotFound
      end
    end
    
    get "/object_templates/:name/generic_objects/filter.json" do |template_name|
      filter = params[:filter]
      relatable_category_values = params[:relatable_category_values]
      begin
        File.read(File.join(File.dirname(__FILE__), "..", "responses", "object_templates_#{template_name}_generic_objects_filter_#{filter}.json"))
      rescue
        raise Sinatra::NotFound
      end
    end

  end
end
