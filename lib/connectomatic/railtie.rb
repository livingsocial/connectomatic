require 'connectomatic'
require 'connectomatic/active_record/base'
require 'connectomatic/active_record/migration'

module Connectomatic
  class Railtie < Rails::Railtie

    rake_tasks do
      load "tasks/connectomatic.rake"
    end

    initializer "connectomatic.active_record" do |app|
      ActiveSupport.on_load(:active_record) do
        ::ActiveRecord::Base.send(:include, Connectomatic::ActiveRecord::Base::ClassMethods)
        ::ActiveRecord::Migration.send(:include, Connectomatic::ActiveRecord::Migration::ClassMethods)
      end
    end

  end
end
