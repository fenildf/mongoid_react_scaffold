module <%= class_name %>Former
  extend ActiveSupport::Concern

  included do
    former "<%= class_name %>" do
      field :id, ->(instance) {instance.id.to_s}
<% attributes.reject{|attr| attr.reference?}.each do |attribute| -%>
      field :<%= attribute.name %>
<% end -%>

      #logic :method, ->(instance) {
      #  instance.method
      #}

      url :update_url, ->(instance) {
        <%= singular_table_name %>_path(instance)
      }

      url :delete_url, ->(instance) {
        <%= singular_table_name %>_path(instance)
      }
    end
  end
end

