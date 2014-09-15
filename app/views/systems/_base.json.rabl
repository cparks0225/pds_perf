attributes :id, :name, :active

node do |system|
  {
    :slug => "/" + system.name.gsub(" ", "-").downcase()
  }
end