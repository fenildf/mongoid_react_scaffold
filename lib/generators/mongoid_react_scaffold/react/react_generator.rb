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

      protected
      def react_class_name
        (controller_class_path + [controller_file_name]).map!{ |m| m.camelize }.join
      end

      def react_prefix
        "#{controller_class_path.join('_')}_" unless controller_class_path.blank?
      end
    end
  end
end
