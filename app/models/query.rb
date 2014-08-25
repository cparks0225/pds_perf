class Query < ActiveRecord::Base
  serialize :data, JSON

  def added_attr
    "ADDED"
  end
end
