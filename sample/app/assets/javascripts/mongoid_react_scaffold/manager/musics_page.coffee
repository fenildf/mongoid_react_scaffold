@ManagerMusicsPage = React.createClass
  getInitialState: ->
    manager_musics: @props.data.manager_musics

  render: ->
    <div className='manager_musics-page'>
    {
      if @state.manager_musics.length is 0
        data =
          header: '设置'
          desc: '还没有创建任何数据'
          init_action: <ManagerMusicsPage.CreateBtn data={@props.data} page={@} />
        <ManagerFuncNotReady data={data} />

      else
        <div>
          <ManagerMusicsPage.CreateBtn data={@props.data} page={@} />
          <ManagerMusicsPage.Table data={@state.manager_musics} page={@} />
        </div>
    }
    </div>

  add_manager_music: (manager_music)->
    manager_musics = Immutable.fromJS @state.manager_musics
    manager_musics = manager_musics.push manager_music
    @setState manager_musics: manager_musics.toJS()

  update_manager_music: (manager_music)->
    manager_musics = Immutable.fromJS @state.manager_musics
    manager_musics = manager_musics.map (x)->
      x = x.merge manager_music if x.get('id') is manager_music.id
      x
    @setState manager_musics: manager_musics.toJS()

  delete_manager_music: (manager_music)->
    manager_musics = Immutable.fromJS @state.manager_musics
    manager_musics = manager_musics.filter (x)->
      x.get('id') != manager_music.id
    @setState manager_musics: manager_musics.toJS()

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

        jQuery.open_modal <ManagerMusicsPage.Form {...params} />

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
            model='manager_music'
            post={@props.url}
            done={@done}  
          >

            <TextInputField {...layout} label='name：' name='name' />
            <TextInputField {...layout} label='views：' name='views' />
            <Submit {...layout} text='确定保存' />
          </SimpleDataForm>
        </div>

      done: (data)->
        @props.page.add_manager_music data.manager_music
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
            model='manager_music'
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
        @props.page.update_manager_music data.manager_music
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

      edit: (manager_music)->
        =>
          params =
            url: manager_music.manager_update_url
            title: '修改'
            page: @props.page
            data: manager_music

          jQuery.open_modal <ManagerMusicsPage.UpdateForm {...params} />

      delete: (manager_music)->
        =>
          jQuery.modal_confirm
            text: '确定要删除吗？'
            yes: =>
              jQuery.ajax
                type: 'DELETE'
                url: manager_music.manager_delete_url
              .done =>
                @props.page.delete_manager_music manager_music
