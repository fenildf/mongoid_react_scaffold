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

      #url :test_url, ->(instance) {
      #  test_path(instance)
      #}
    end
  end
end

