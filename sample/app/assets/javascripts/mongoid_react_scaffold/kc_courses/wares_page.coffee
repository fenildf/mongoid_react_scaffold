@KcCoursesWaresPage = React.createClass
  getInitialState: ->
    kc_courses_wares: @props.data.kc_courses_wares

  render: ->
    <div className='kc_courses_wares-page'>
    {
      if @state.kc_courses_wares.length is 0
        data =
          header: '设置'
          desc: '还没有创建任何数据'
          init_action: <KcCoursesWaresPage.CreateBtn data={@props.data} page={@} />
        <ManagerFuncNotReady data={data} />

      else
        <div>
          <KcCoursesWaresPage.CreateBtn data={@props.data} page={@} />
          <KcCoursesWaresPage.Table data={@state.kc_courses_wares} page={@} />
        </div>
    }
    </div>

  add_kc_courses_ware: (kc_courses_ware)->
    kc_courses_wares = Immutable.fromJS @state.kc_courses_wares
    kc_courses_wares = kc_courses_wares.push kc_courses_ware
    @setState kc_courses_wares: kc_courses_wares.toJS()

  update_kc_courses_ware: (kc_courses_ware)->
    kc_courses_wares = Immutable.fromJS @state.kc_courses_wares
    kc_courses_wares = kc_courses_wares.map (x)->
      x = x.merge kc_courses_ware if x.get('id') is kc_courses_ware.id
      x
    @setState kc_courses_wares: kc_courses_wares.toJS()

  delete_kc_courses_ware: (kc_courses_ware)->
    kc_courses_wares = Immutable.fromJS @state.kc_courses_wares
    kc_courses_wares = kc_courses_wares.filter (x)->
      x.get('id') != kc_courses_ware.id
    @setState kc_courses_wares: kc_courses_wares.toJS()

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

        jQuery.open_modal <KcCoursesWaresPage.Form {...params} />

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
            model='kc_courses_ware'
            post={@props.url}
            done={@done}  
          >

            <TextInputField {...layout} label='name：' name='name' />
            <TextInputField {...layout} label='views：' name='views' />
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>

      done: (data)->
        @props.page.add_kc_courses_ware data.kc_courses_ware
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
            model='kc_courses_ware'
            put={@props.url}
            done={@done}
            data={@props.data}  
          >

            <TextInputField {...layout} label='name：' name='name' />
            <TextInputField {...layout} label='views：' name='views' />
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>

      done: (data)->
        @props.page.update_kc_courses_ware data.kc_courses_ware
        @state.close()

    Table: React.createClass
      render: ->
        table_data = {
          fields:

            name: 'name'
            views: 'views'
            ops: '操作'
          data_set: @props.data.map (x)=>
            id: x.id

            name: x.name
            views: x.views
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

      edit: (kc_courses_ware)->
        =>
          params =
            url: kc_courses_ware.kc_courses_update_url
            title: '修改'
            page: @props.page
            data: kc_courses_ware

          jQuery.open_modal <KcCoursesWaresPage.UpdateForm {...params} />

      delete: (kc_courses_ware)->
        =>
          jQuery.modal_confirm
            text: '确定要删除吗？'
            yes: =>
              jQuery.ajax
                type: 'DELETE'
                url: kc_courses_ware.kc_courses_delete_url
              .done =>
                @props.page.delete_kc_courses_ware kc_courses_ware
