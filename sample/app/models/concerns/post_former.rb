module PostFormer
  extend ActiveSupport::Concern

  included do
    former "Post" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :user_id

      #logic :method, ->(instance) {
      #  instance.method
      #}

      url :update_url, ->(instance) {
        post_path(instance)
      }

      url :delete_url, ->(instance) {
        post_path(instance)
      }
    end
  end
end

