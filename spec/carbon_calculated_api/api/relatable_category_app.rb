module CarbonCalculatedApi
  class RelatableCategoryApp < API::App
    
  
    get "/relatable_categories/related_objects.json" do
      begin
        @relatable_category_ids, @template_name = params[:relatable_category_ids], params[:template_name]
        raise Exception if !@relatable_category_ids.is_a?(Array)
        if @relatable_category_ids && @template_name
           File.read(File.join(File.dirname(__FILE__), "..", "responses", "related_objects_from_relatable_category_#{@template_name}.json"))
        else
          throw :halt, [412, "Params: either relatable_category_ids or template_name was not given"]
        end
      rescue Exception => e
        throw :halt, [412, "Params: either relatable_category_ids or template_name was not given"]
      end
    end
    
    get "/relatable_categories/:id/related_categories.json" do |id|
      if @related_attribute = params[:related_attribute]
        begin
          File.read(File.join(File.dirname(__FILE__), "..", "responses", "relatable_categories_from_relatable_category_related_attribute_#{@related_attribute}.json"))
        rescue
           raise Sinatra::NotFound
        end
      else
        throw :halt, [412, "Params: related_attribute was not given"]
      end
    end
    
  end
end
