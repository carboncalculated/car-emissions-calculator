require "active_support/json/encoding"
module CarbonCalculatedApi
  module API
    def self.app
      
      # == Build Version 1 Application
      @version1 ||= Rack::Builder.app do
        use CarbonCalculatedApi::GenericObjectApp
        use CarbonCalculatedApi::AnswerApp
        use CarbonCalculatedApi::ObjectTemplateApp
        run CarbonCalculatedApi::RelatableCategoryApp
      end
      
      @api_mapper ||= Rack::APIVersionMapper.new do |m|
        m.add_version 1, @version1
        m.current_version = 1
      end
    end
    
    class App < Sinatra::Base

      # getting some shit with .xsl being first 
      # in accpect form as the inverse has 2 entries
      Rack::Mime::MIME_TYPES.delete(".xsl")
      use Rack::AcceptFormat
      
      set :raise_errors, false
      set :show_exceptions, false
            
      before do
        response['Content-Type'] = 'application/json'        
      end
      
      before do
        if params[:api_key]
          unless ApiUser.first(:model_state => "active", :api_key => params[:api_key])
            throw(:halt, [401, {:error => "Not authorized"}.to_json])
          end
        else
          throw(:halt, [401, {:error => "Not authorized"}.to_json])
        end
      end
      
      before do
        if params
          @per_page = params[:per_page] || 50
          @page = params[:page] || 1
        end
      end
                  
      not_found do
        {:errors => "Resource Not Found"}.to_json
      end
            
    end 
  end
end



