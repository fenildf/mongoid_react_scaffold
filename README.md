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

初次运行：
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mongoid_react_scaffold. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

