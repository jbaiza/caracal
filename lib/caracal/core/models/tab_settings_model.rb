require 'caracal/core/models/base_model'
require 'caracal/core/models/tab_model'
require 'caracal/errors'


module Caracal
  module Core
    module Models

      # This class handles block options passed to the margins
      # method.
      #
      class TabSettingsModel < BaseModel

        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # accessors
        attr_reader :tab_settings


        # initialization
        def initialize(options={}, &block)

          super options, &block
        end


        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------

        #=============== SETTERS ==============================

        # .settings
        def settings(value)
          begin
            @tab_settings = value.map do |tab|
              puts "DEBUG: #{tab}"
              case tab
              when Caracal::Core::Models::TabModel
                tab
              when Hash
                Caracal::Core::Models::TabModel.new(tab)
              when Proc
                Caracal::Core::Models::TabModel.new(&tab)
              else
                Caracal::Core::Models::TabModel.new({ content: data_cell.to_s })
              end
            end
          rescue
            raise Caracal::Errors::InvalidTableDataError, 'Tab settings must be an array.'
          end
        end

        #=============== VALIDATION ==============================

        def valid?
          @tab_settings && @tab_settings.all? { |s| s.valid? }
        end

        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private

        def option_keys
          [:settings]
        end
      end

    end
  end
end
