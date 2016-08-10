@<%= react_class_name %>Page = React.createClass
  getInitialState: ->
    <%= plural_table_name %>: @props.data.<%= plural_table_name %>

  render: ->
    <div className='<%= plural_table_name %>-page'>
    {
      if @state.<%= plural_table_name %>.length is 0
        data =
          header: '设置'
          desc: '还没有创建任何数据'
          init_action: <<%= react_class_name %>Page.CreateBtn data={@props.data} page={@} />
        <ManagerFuncNotReady data={data} />

      else
        <div>
          <<%= react_class_name %>Page.CreateBtn data={@props.data} page={@} />
          <<%= react_class_name %>Page.Table data={@state.<%= plural_table_name %>} page={@} />
        </div>
    }
    </div>

  add_<%= singular_table_name %>: (<%= singular_table_name %>)->
    <%= plural_table_name %> = Immutable.fromJS @state.<%= plural_table_name %>
    <%= plural_table_name %> = <%= plural_table_name %>.push <%= singular_table_name %>
    @setState <%= plural_table_name %>: <%= plural_table_name %>.toJS()

  update_<%= singular_table_name %>: (<%= singular_table_name %>)->
    <%= plural_table_name %> = Immutable.fromJS @state.<%= plural_table_name %>
    <%= plural_table_name %> = <%= plural_table_name %>.map (x)->
      x = x.merge <%= singular_table_name %> if x.get('id') is <%= singular_table_name %>.id
      x
    @setState <%= plural_table_name %>: <%= plural_table_name %>.toJS()

  delete_<%= singular_table_name %>: (<%= singular_table_name %>)->
    <%= plural_table_name %> = Immutable.fromJS @state.<%= plural_table_name %>
    <%= plural_table_name %> = <%= plural_table_name %>.filter (x)->
      x.get('id') != <%= singular_table_name %>.id
    @setState <%= plural_table_name %>: <%= plural_table_name %>.toJS()

  statics:
    CreateBtn: React.createClass
      render: ->
        <a className='ui button green mini' href='javascript:;' onClick={@show_modal}>
          <i className='icon plus' />
          创建
        </a>

      show_modal: ->
        params =
          url: @props.data.create_url
          title: '创建'
          page: @props.page

        jQuery.open_modal <<%= react_class_name %>Page.Form {...params} />

    Form: React.createClass
      render: ->
        {
          TextInputField
          Submit
        } = DataForm

        layout =
          label_width: '100px'

        <div>
          <h3 className='ui header'>{@props.title}</h3>
          <SimpleDataForm
            model='<%= singular_table_name %>'
            post={@props.url}
            done={@done}  
          >
<% attributes.reject{|attr| attr.reference?}.each do |attribute| -%>
            <TextInputField {...layout} label='<%= attribute.name %>：' name='<%= attribute.name %>' /><% end -%>
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>

      done: (data)->
        @props.page.add_<%= singular_table_name %> data.<%= singular_table_name %>
        @state.close()

    UpdateForm: React.createClass
      render: ->
        {
          TextInputField
          Submit
        } = DataForm

        layout =
          label_width: '100px'

        <div>
          <h3 className='ui header'>{@props.title}</h3>
          <SimpleDataForm
            model='<%= singular_table_name %>'
            put={@props.url}
            done={@done}
            data={@props.data}  
          >
<% attributes.reject{|attr| attr.reference?}.each do |attribute| -%>
            <TextInputField {...layout} label='<%= attribute.name %>：' name='<%= attribute.name %>' /><% end -%>
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>

      done: (data)->
        @props.page.update_<%= singular_table_name %> data.<%= singular_table_name %>
        @state.close()

    Table: React.createClass
      render: ->
        table_data = {
          fields:
<% attributes.reject{|attr| attr.reference?}.each do |attribute| -%>
            <%= attribute.name %>: '<%= attribute.name %>'<% end -%>
            ops: '操作'
          data_set: @props.data.map (x)=>
            id: x.id
<% attributes.reject{|attr| attr.reference?}.each do |attribute| -%>
            <%= attribute.name %>: x.<%= attribute.name %><% end -%>
            ops:
              <div>
                <a href='javascript:;' className='ui basic button blue mini' onClick={@edit(x)}>
                  <i className='icon edit' /> 修改
                </a>
                <a href='javascript:;' className='ui basic button red mini' onClick={@delete(x)}>
                  <i className='icon trash' /> 删除
                </a>
              </div>

          th_classes: {
            number: 'collapsing'
          }
          td_classes: {
            ops: 'collapsing'
          }
        }

        <div className='ui segment'>
          <ManagerTable data={table_data} title='' />
        </div>

      edit: (<%= singular_table_name %>)->
        =>
          params =
            url: <%= singular_table_name %>.<%=  react_prefix %>update_url
            title: '修改'
            page: @props.page
            data: <%= singular_table_name %>

          jQuery.open_modal <<%= react_class_name %>Page.UpdateForm {...params} />

      delete: (<%= singular_table_name %>)->
        =>
          jQuery.modal_confirm
            text: '确定要删除吗？'
            yes: =>
              jQuery.ajax
                type: 'DELETE'
                url: <%= singular_table_name %>.<%=  react_prefix %>delete_url
              .done =>
                @props.page.delete_<%= singular_table_name %> <%= singular_table_name %>
