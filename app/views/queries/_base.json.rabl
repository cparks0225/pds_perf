attributes :id, :method, :url, :data, :created_at, :updated_at, :added_attr

node do |query|
  {
    :created_at_formatted => query.created_at.strftime("%m/%d/%Y"),
    :updated_at_formatted => query.updated_at.strftime("%m/%d/%Y"),
    :created_at_in_words => time_ago_in_words(query.created_at),
    :updated_at_in_words => time_ago_in_words(query.updated_at)
  }
end