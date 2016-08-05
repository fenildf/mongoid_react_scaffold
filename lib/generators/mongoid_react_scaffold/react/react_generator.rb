# encoding: utf-8
require 'rails/generators/resource_helpers'
require "rails/generators/mongoid/model/model_generator"

module MongoidReactScaffold
  module Generators
    class ReactGenerator < ::Rails::Generators::NamedBase
      include ::Rails::Generators::ResourceHelpers
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a MongoidReactScaffold React components"

      check_class_collision suffix: "Page"

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def create_controller_files
        template "page.coffee", File.join('app/assets/javascripts/mongoid_react_scaffold', controller_class_path, "#{controller_file_name}_page.coffee")
      end
    end
  end
end
