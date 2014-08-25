attributes :id, :riskapi, :pds, :token, :created_at, :updated_at

node do |query|
  {
    :risklogin => query.riskapi + "/login"
  }
end