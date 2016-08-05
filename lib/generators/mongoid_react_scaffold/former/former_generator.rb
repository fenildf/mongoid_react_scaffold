# encoding: utf-8
require "rails/generators/mongoid/model/model_generator"

module MongoidReactScaffold
  module Generators
    class FormerGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a former"
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      check_class_collision

      class_option :parent,     type: :string, desc: "The parent class for the generated model"
      class_option :collection, type: :string, desc: "The collection for storing model's documents"

      def create_former
        template "former.rb", File.join("app/models/concerns/", class_path, "#{file_name}_former.rb")
      end

      def add_to_data_former
        sentinel = /DataFormerConfig\s*\n/m
        inject_into_file 'app/models/data_former.rb', "  include #{class_name}Former\n", { after: sentinel, verbose: false, force: true } 
      end

      #hook_for :test_framework
    end
  end
end
