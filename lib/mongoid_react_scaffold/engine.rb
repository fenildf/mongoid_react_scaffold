module MongoidReactScaffold
  class Engine < ::Rails::Engine
    isolate_namespace MongoidReactScaffold
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper

      Dir.glob(Rails.root + "app/decorators/mongoid_react_scaffold/**/*_decorator.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
