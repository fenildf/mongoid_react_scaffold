# encoding: utf-8
require 'rails/generators/resource_helpers'
require "rails/generators/mongoid/model/model_generator"

module MongoidReactScaffold
  module Generators
    class ScaffoldControllerGenerator < ::Rails::Generators::NamedBase
      include ::Rails::Generators::ResourceHelpers
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a MongoidReactScaffold Controller"

      check_class_collision suffix: "Controller"

      #class_option :helper, type: :boolean
      #class_option :orm, banner: "NAME", type: :string, required: true,
                         #desc: "ORM to generate the controller for"

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def create_controller_files
        template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      end

      def add_route
        sentinel = /\.routes\.draw do\s*\n/m
        inject_into_file 'config/routes.rb', "  resources :#{file_name.pluralize}\n", { after: sentinel, verbose: false, force: true }
      end

      #hook_for :template_engine, :test_framework, as: :scaffold

      # Invoke the helper using the controller name (pluralized)
      #hook_for :helper, as: :scaffold do |invoked|
        #invoke invoked, [ controller_name ]
      #end
      protected
      def react_prefix
        "#{controller_class_path.join('_')}_" unless controller_class_path.blank?
      end
    end
  end
end

