require 'caracal/core/models/base_model'


module Caracal
  module Core
    module Models

      # This class handles block options passed to the margins
      # method.
      #
      class TabModel < BaseModel

        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # constants
        const_set(:DEFAULT_TAB_POS, 0)
        const_set(:DEFAULT_TAB_VAL, :left)
        const_set(:DEFAULT_TAB_LEADER, :none)

        # accessors
        attr_reader :tab_pos
        attr_reader :tab_val
        attr_reader :tab_leader


        # initialization
        def initialize(options={}, &block)
          @tab_pos = DEFAULT_TAB_POS
          @tab_val = DEFAULT_TAB_VAL
          @tab_leader = DEFAULT_TAB_LEADER

          super options, &block
        end


        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------

        #=============== SETTERS ==============================

        # integers
        [:pos].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@tab_#{ m }", value.to_i)
          end
        end

        #symbols
        [:val, :leader].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@tab_#{ m }", value.to_s.to_sym)
          end
        end

        #=============== VALIDATION ==============================

        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private

        def option_keys
          [:pos, :val, :leader]
        end

      end

    end
  end
end
