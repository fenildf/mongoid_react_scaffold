<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  def index
    @page_name = "<%= plural_table_name %>"
    <%= plural_table_name %> = <%= human_name %>.all.map do |<%= singular_table_name %>|
      DataFormer.new(<%= singular_table_name %>)
        .data
    end

    @component_data = {
      <%= plural_table_name %>: <%= plural_table_name %>,
      create_url: <%= plural_table_name %>_path
    }

    render "/mockup/page"
  end

  def create
    <%= singular_table_name %> = <%= human_name %>.new "#{singular_table_name}_params"

    save_model(<%= singular_table_name %>, "<%= singular_table_name %>") do |_<%= singular_table_name %>|
      DataFormer.new(_<%= singular_table_name %>)
        .data
    end
  end

  def update
    <%= singular_table_name %> = <%= human_name %>.find params[:id]

    update_model(<%= singular_table_name %>, <%= singular_table_name %>_params, "<%= singular_table_name %>") do |_<%= singular_table_name %>|
      DataFormer.new(_<%= singular_table_name %>)
        .data
    end
  end

  def destroy
    <%= singular_table_name %> = <%= human_name %>.find params[:id]
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
