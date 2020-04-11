require 'caracal/core/models/margin_model'

module Caracal
  module Core
    module Models

      # This class handles block options passed to the margins
      # method.
      #
      class PageMarginModel < MarginModel

        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # accessors
        attr_reader :margin_header
        attr_reader :margin_footer


        # initialization
        def initialize(options={}, &block)
          super options, &block
        end


        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------

        #=============== SETTERS ==============================

        # integers
        [:header, :footer].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@margin_#{ m }", value.to_i)
          end
        end


        #=============== VALIDATION ==============================

        def valid?
          dims = [:header, :footer]
          super && dims.map { |d| send("margin_#{ d }") }.all? { |d| d ? d > 0 : true }
        end


        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private

        def option_keys
          super.concat(%i(header, footer))
        end

      end

    end
  end
end
