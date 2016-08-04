# encoding: utf-8
require "rails/generators/mongoid/model/model_generator"

module MongoidReactScaffold
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a Mongoid model"
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      check_class_collision

      class_option :parent,     type: :string, desc: "The parent class for the generated model"
      class_option :collection, type: :string, desc: "The collection for storing model's documents"

      def create_model_file
        template "model.rb", File.join("app/models", class_path, "#{file_name}.rb")
      end

      hook_for :test_framework
    end
  end
end
