# == Compressed Saas please
if ["production", "staging"].include? Rails.env
  Sass::Plugin.options[:style] = :compressed
end

# == Simple app config
module CarApp
  def self.[](key)
    unless @config
      raw_config = File.read(File.join(File.dirname(__FILE__), "../../config", "car_app.yml"))
      @config = YAML.load(raw_config)[Rails.env].symbolize_keys
    end
    @config[key]
  end
  
  def self.[]=(key, value)
    @config[key.to_sym] = value
  end
  
  def self.calculated_session
    @session ||= Calculated::Session.create(:server => CarApp[:api_server], :api_key => ::CarApp[:api_key])
  end
end

