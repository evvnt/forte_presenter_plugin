module Voom
  module Presenters
    module Plugins
      module Forte
        class CreateForteToken < DSL::Components::Actions::Base
          def initialize(**attribs_, &block)
            super(type: :create_forte_token, **attribs_, &block)
          end
        end
      end
    end
  end
end