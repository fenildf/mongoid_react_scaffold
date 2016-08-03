module MongoidReactScaffold
  class << self
    def mongoid_react_scaffold_config
      self.instance_variable_get(:@mongoid_react_scaffold_config) || {}
    end

    def set_mount_prefix(mount_prefix)
      config = MongoidReactScaffold.mongoid_react_scaffold_config
      config[:mount_prefix] = mount_prefix
      MongoidReactScaffold.instance_variable_set(:@mongoid_react_scaffold_config, config)
    end

    def get_mount_prefix
      mongoid_react_scaffold_config[:mount_prefix]
    end
  end
end

# 引用 rails engine
require 'mongoid_react_scaffold/engine'
require 'mongoid_react_scaffold/rails_routes'
