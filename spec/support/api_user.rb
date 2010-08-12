class ApiUser < Hashie::Dash
  
  @@records = []
  property :email
  property :api_key
  property :model_state, :default => "active"
  
  def self.record(api_user)
    @@records << api_user
  end
  
  def self.first(*args)
    @@records.first
  end
end