require 'rails'
require 'shellwords'

module MongoidReactScaffold
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)


      def copy_data_former
        copy_file "data_former.rb", "app/models/data_former.rb"
        copy_file "data_former_config.rb", "app/models/concerns/data_former_config.rb"
      end

      def copy_react_page
        copy_file "page.html.haml", "app/views/react/page.html.haml"
      end

      def copy_assets
        %w[class_name.coffee jquery-open-modal.coffee jquery_extension.coffee].each do |f|
          copy_file "utils/#{f}", "app/assets/javascripts/mongoid_react_scaffold/utils/#{f}"
        end

        %w[data_form.coffee func_not_ready.coffee manager_table.coffee  modal_confirm.coffee].each do |f|
          copy_file "widgets/#{f}", "app/assets/javascripts/mongoid_react_scaffold/widgets/#{f}"
        end
      end
    end
  end
end
