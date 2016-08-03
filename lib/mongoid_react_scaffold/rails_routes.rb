module MongoidReactScaffold
  class Routing
    # MongoidReactScaffold::Routing.mount "/mongoid_react_scaffold", :as => 'mongoid_react_scaffold'
    def self.mount(prefix, options)
      MongoidReactScaffold.set_mount_prefix prefix

      Rails.application.routes.draw do
        mount MongoidReactScaffold::Engine => prefix, :as => options[:as]
      end
    end
  end
end
