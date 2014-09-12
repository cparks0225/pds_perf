attributes :id, :name

node do |system|
  {
    :slug => system.name.gsub(" ", "-").downcase()
  }
end