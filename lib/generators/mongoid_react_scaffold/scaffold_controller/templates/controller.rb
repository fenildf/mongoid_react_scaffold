<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  def index
    @page_name = "<%= plural_table_name %>"
    <%= plural_table_name %> = <%= orm_class.all(class_name) %>.map do |<%= singular_table_name %>|
      DataFormer.new(<%= singular_table_name %>)
        .url(:<%= react_prefix %>update_url)
        .url(:<%= react_prefix %>delete_url)
        .data
    end

    @component_data = {
      <%= plural_table_name %>: <%= plural_table_name %>,
      create_url: <%= plural_table_name %>_path
    }

    render "/react/page"
  end

  def create
    <%= singular_table_name %> = <%= orm_class.build(class_name) %> <%= singular_table_name %>_params

    save_model(<%= singular_table_name %>, "<%= singular_table_name %>") do |_<%= singular_table_name %>|
      DataFormer.new(_<%= singular_table_name %>)
        .url(:<%= react_prefix %>update_url)
        .url(:<%= react_prefix %>delete_url)
        .data
    end
  end

  def update
    <%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>

    update_model(<%= singular_table_name %>, <%= singular_table_name %>_params, "<%= singular_table_name %>") do |_<%= singular_table_name %>|
      DataFormer.new(_<%= singular_table_name %>)
        .url(:<%= react_prefix %>update_url)
        .url(:<%= react_prefix %>delete_url)
        .data
    end
  end

  def destroy
    <%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    <%= singular_table_name %>.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
