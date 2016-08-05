class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :user_id, type: Integer
end
