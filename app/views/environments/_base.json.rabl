attributes :id, :name, :riskapi, :pds, :system, :active

node do |env|
  { :risklogin => env.riskapi + "/login" }
  { :slug => "/" + env.name.gsub(" ", "-").downcase() }
end
