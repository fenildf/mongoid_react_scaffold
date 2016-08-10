module KcCoursesWareFormer
  extend ActiveSupport::Concern

  included do
    former "KcCourses::Ware" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :views

      #logic :method, ->(instance) {
      #  instance.method
      #}

      url :update_url, ->(instance) {
        ware_path(instance)
      }

      url :delete_url, ->(instance) {
        ware_path(instance)
      }

      url :kc_courses_update_url, ->(instance) {
        kc_courses_ware_path(instance)
      }

      url :kc_courses_delete_url, ->(instance) {
        kc_courses_ware_path(instance)
      }
    end
  end
end
