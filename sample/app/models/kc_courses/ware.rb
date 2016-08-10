class KcCourses::Ware
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :views, type: Integer
end
