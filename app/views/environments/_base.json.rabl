attributes :id, :name, :riskapi, :pds, :token, :system

node do |env|
  { :risklogin => env.riskapi + "/login" }
  { :slug => "/" + env.name.gsub(" ", "-").downcase() }
end
