require 'connectomatic'

module Connectomatic
  module ActiveRecord
    module Migration

      extend ActiveSupport::Concern

      module ConnectionToggle
        def migrate_with_connection_toggle(direction)
          announce "migrating using connection #{self.connectomatic_conn}"
          ::ActiveRecord::Base.establish_connection Connectomatic.config_for(self.connectomatic_conn)
          migrate_without_connection_toggle(direction)
          ::ActiveRecord::Base.establish_connection Connectomatic.config_for(:default)
          nil
        end
      end

      module ClassMethods
        def connectomatic(name)
          include Connectomatic::ActiveRecord::Migration::ConnectionToggle
          alias_method_chain :migrate,:connection_toggle
          cattr_accessor :connectomatic_conn
          self.connectomatic_conn = name
        end
      end

    end
  end
end
