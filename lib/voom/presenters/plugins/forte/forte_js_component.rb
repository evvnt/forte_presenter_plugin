require 'voom/presenters/dsl/components/base'

module Voom
  module Presenters
    module Plugins
      module Forte
        class ForteJsComponent < DSL::Components::Base
          attr_reader :env
          def initialize(env: env, **attribs_, &block)
            @env = env  
            super(type: :forte_js, **attribs_, &block)
          end
        end
      end
    end
  end
end
