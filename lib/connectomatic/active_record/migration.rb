require 'connectomatic'

module Connectomatic
  module ActiveRecord
    module Migration
      module ClassMethods

        def connectomatic(db_name)
          ::ActiveRecord::Base.establish_connection Connectomatic.config_for(db_name)
        end

      end
    end
  end
end
