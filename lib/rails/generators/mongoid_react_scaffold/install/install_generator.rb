require 'rails'
require 'shellwords'

module MongoidReactScaffold
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_unicorn_config
        copy_file "page.html.haml", "app/views/react/page.html.haml"
      end
    end
  end
end
