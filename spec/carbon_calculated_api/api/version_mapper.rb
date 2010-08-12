require 'rack'
module Rack
  class APIVersionMapper
    
    ERROR_TEXT      = '<html><head><title>Unknown API Version</title></head><body>Unknown API Version v%s</body></html>'.freeze
    EMPTY_RESPONSE  = [404, {'Content-Type' => 'text/html', 'Content-Length' => '0'}, ['']].freeze
    VERSION_ENV_KEY = 'x-rack.api_mapper.version'.freeze
    QUERY_STRING    = "QUERY_STRING".freeze
    
    class VersionWrapper
      
      def initialize(app, version, mapper)
        @app = app
        @version = version
        @mapper = mapper
      end
      
      def call(env)
        env[VERSION_ENV_KEY] = @version
        if @mapper.add_param?
          env[QUERY_STRING] << "&" unless env[QUERY_STRING] == ""
          env[QUERY_STRING] << "api_version=#{@version}"
        end
        @app.call(env)
      end
      
    end
    
    UnknownVersionResponder = proc do |env|
      if env["PATH_INFO"].to_s.squeeze("/") =~ /^\/v?([^\/]+)/
        body = ERROR_TEXT % $1
        [404, {"Content-Type" => "text/html", "Content-Length" => body.size.to_s}, [body]]
      else
        EMPTY_RESPONSE
      end
    end
    
    def initialize(options = {}, &blk)
      @api_versions = {}
      @add_param = options.delete(:add_param)
      blk.arity == 1 ? blk.call(self) : instance_eval(&blk) if block_given?
    end
    
    def add_version(version, app)
      @app = nil
      version_string = version.to_s.gsub(/^v/, '')
      @api_versions[version_string] = VersionWrapper.new(app, version, self)
      true
    end
    
    def call(env)
      (@app ||= build_url_mapper).call(env)
    end
    
    def current_version=(value)
      @current_version = value.to_s
    end
    
    def current_version
      @current_version ||= @api_versions.keys.max
    end
    
    def add_param?
      @add_param
    end
    
    def add_param=(value)
      @add_param = value
    end
    
    private
    def build_url_mapper
      version_url_mapping = {}
      @api_versions.each do |version, app|
        version_url_mapping["/api/v#{version}"] = app
        version_url_mapping["/api/current"] = app if version == current_version
      end
      version_url_mapping["/api"] = UnknownVersionResponder
      Rack::URLMap.new(version_url_mapping)
    end
    
  end
end