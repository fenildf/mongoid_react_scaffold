# MongoidReactScaffold

Mindpin 自制 Scaffold

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_react_scaffold', github: 'mindpin/mongoid_react_scaffold'

# 以下为其余依赖项
# for semantic
gem 'semantic-ui-sass', '~> 2.2.2.2'

# for react
gem 'react-rails', '1.8.1'
gem 'sprockets-coffee-react', '4.0.0'

# 通过 rails assets 服务加载前端包
source 'https://rails-assets.org'
gem 'rails-assets-semantic'

#http://medialize.github.io/URI.js/
gem 'rails-assets-URIjs'
# http://facebook.github.io/immutable-js/
gem 'rails-assets-immutable'
# https://github.com/Olical/EventEmitter/blob/master/docs/guide.md
gem 'rails-assets-eventEmitter'
# for react end
```

And then execute:

    $ bundle

## 使用说明

### 初次运行
```shell
rails g mongoid_react_scaffold:install
```

配置：
```
// app/assets/javascripts/application.js
// 添加以下内容:
//
//= require mongoid_react_scaffold
```

```
// app/assets/stylesheets/application.css
//= require 'mongoid_react_scaffold'
```

```
# app/controllers/application_controller.rb
# 添加以下依赖
  include MongoidReactScaffoldHelper
```

### 模型生成(支持多层)
```
rails g mongoid_react_scaffold:model post name views:integer
```

和 **rails g model** 相同


### Former生成(支持module)
```
rails g mongoid_react_scaffold:former post name views:integer
```

自动在 **app/models/concerns/** 生成对应的模型Former

然后添加到 **app/models/data_former.rb** 中

并include

### 控制器生成(支持module)
```
rails g mongoid_react_scaffold:scaffold_controller post name views:integer
```

自动生成对应的控制器(仅index,create,update,destroy)

并添加对应路由到 **config/routes.rb**

ps：
多次执行会重复插入，且如有命名空间，需要自行整理，否则比较凌乱。


### React生成(支持module)
```
rails g mongoid_react_scaffold:react post name views:integer
```

生成对应的React Page


## 实例
### 简单文章示例
在加载了此gem的项目，执行以下命令
```shell
rails g mongoid_react_scaffold:model post name views:integer
rails g mongoid_react_scaffold:former post name views:integer
rails g mongoid_react_scaffold:scaffold_controller post name views:integer
rails g mongoid_react_scaffold:react post name views:integer

rails s
```

[点我访问](http://localhost:3000/posts)

### 课程KcCourses::Course(带module的MVC)
```shell
rails g mongoid_react_scaffold:model kc_courses/ware name views:integer
rails g mongoid_react_scaffold:former kc_courses/ware name views:integer
rails g mongoid_react_scaffold:scaffold_controller kc_courses/ware name views:integer
rails g mongoid_react_scaffold:react kc_courses/ware name views:integer

rails s
```

[点我访问](http://localhost:3000/kc_courses/wares)


### 管理员管理音乐(带module的CV, 不带module的M)
```shell
rails g mongoid_react_scaffold:model music name views:integer
rails g mongoid_react_scaffold:former music name views:integer
rails g mongoid_react_scaffold:scaffold_controller manager/music name views:integer
rails g mongoid_react_scaffold:react manager/music name views:integer

rails s
```

编辑 **app/models/concerns/music_former.rb**

添加 **manager_xxx_url**
```ruby
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
```

编辑 **app/controllers/musics_controller.rb**

将 **Manager::Music** 替换为 **Music**
```ruby
class Manager::MusicsController < ApplicationController
  def index
    @page_name = "manager_musics"
    manager_musics = Music.all.map do |manager_music|
      DataFormer.new(manager_music)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end

    @component_data = {
      manager_musics: manager_musics,
      create_url: manager_musics_path
    }

    render "/react/page"
  end

  def create
    manager_music = Music.new manager_music_params

    save_model(manager_music, "manager_music") do |_manager_music|
      DataFormer.new(_manager_music)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end
  end

  def update
    manager_music = Music.find(params[:id])

    update_model(manager_music, manager_music_params, "manager_music") do |_manager_music|
      DataFormer.new(_manager_music)
        .url(:manager_update_url)
        .url(:manager_delete_url)
        .data
    end
  end

  def destroy
    manager_music = Music.find(params[:id])
    manager_music.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def manager_music_params
      params.require(:manager_music).permit(:name, :views)
    end
end
```

[点我访问](http://localhost:3000/manager/musics)


### 课程KcCourses::Course(带module的M,单层的CV)
```shell
rails g mongoid_react_scaffold:model kc_courses/course name views:integer
rails g mongoid_react_scaffold:former kc_courses/course name views:integer
rails g mongoid_react_scaffold:scaffold_controller course name views:integer
rails g mongoid_react_scaffold:react course name views:integer

rails s
```

编辑 **app/controllers/courses_controller.rb**

将 **Course** Model替换为 **KcCourses::Course** (控制器名不变)
```ruby
class CoursesController < ApplicationController
  def index
    @page_name = "courses"
    courses = KcCourses::Course.all.map do |course|
      DataFormer.new(course)
        .url(:update_url)
        .url(:delete_url)
        .data
    end

    @component_data = {
      courses: courses,
      create_url: courses_path
    }

    render "/react/page"
  end

  def create
    course = KcCourses::Course.new course_params

    save_model(course, "course") do |_course|
      DataFormer.new(_course)
        .url(:update_url)
        .url(:delete_url)
        .data
    end
  end

  def update
    course = KcCourses::Course.find(params[:id])

    update_model(course, course_params, "course") do |_course|
      DataFormer.new(_course)
        .url(:update_url)
        .url(:delete_url)
        .data
    end
  end

  def destroy
    course = KcCourses::Course.find(params[:id])
    course.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def course_params
      params.require(:course).permit(:name, :views)
    end
end
```

[点我访问](http://localhost:3000/courses)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mongoid_react_scaffold. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

