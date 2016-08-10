@CoursesPage = React.createClass
  getInitialState: ->
    courses: @props.data.courses

  render: ->
    <div className='courses-page'>
    {
      if @state.courses.length is 0
        data =
          header: '设置'
          desc: '还没有创建任何数据'
          init_action: <CoursesPage.CreateBtn data={@props.data} page={@} />
        <ManagerFuncNotReady data={data} />

      else
        <div>
          <CoursesPage.CreateBtn data={@props.data} page={@} />
          <CoursesPage.Table data={@state.courses} page={@} />
        </div>
    }
    </div>

  add_course: (course)->
    courses = Immutable.fromJS @state.courses
    courses = courses.push course
    @setState courses: courses.toJS()

  update_course: (course)->
    courses = Immutable.fromJS @state.courses
    courses = courses.map (x)->
      x = x.merge course if x.get('id') is course.id
      x
    @setState courses: courses.toJS()

  delete_course: (course)->
    courses = Immutable.fromJS @state.courses
    courses = courses.filter (x)->
      x.get('id') != course.id
    @setState courses: courses.toJS()

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

        jQuery.open_modal <CoursesPage.Form {...params} />

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
            model='course'
            post={@props.url}
            done={@done}  
          >

            <TextInputField {...layout} label='name：' name='name' />
            <TextInputField {...layout} label='views：' name='views' />
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>

      done: (data)->
        @props.page.add_course data.course
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
            model='course'
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
        @props.page.update_course data.course
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

      edit: (course)->
        =>
          params =
            url: course.update_url
            title: '修改'
            page: @props.page
            data: course

          jQuery.open_modal <CoursesPage.UpdateForm {...params} />

      delete: (course)->
        =>
          jQuery.modal_confirm
            text: '确定要删除吗？'
            yes: =>
              jQuery.ajax
                type: 'DELETE'
                url: course.delete_url
              .done =>
                @props.page.delete_course course
