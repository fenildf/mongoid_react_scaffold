module MusicFormer
  extend ActiveSupport::Concern

  included do
    former "Music" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :views

      #logic :method, ->(instance) {
      #  instance.method
      #}

      url :update_url, ->(instance) {
        music_path(instance)
      }

      url :delete_url, ->(instance) {
        music_path(instance)
      }

      ### 添加以下内容(module)
      url :manager_update_url, ->(instance) {
        manager_music_path(instance)
      }

      url :manager_delete_url, ->(instance) {
        manager_music_path(instance)
      }
    end
  end
end
