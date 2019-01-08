require_relative 'forte/component'
module Voom
  module Presenters
    module Plugins
      module Forte
        module DSLMethods
          def forte(**attributes, &block)
            if defined?(Rails) && Rails.env
              env = Rails.env
            else
              env = 'development'
            end
            self << Forte::Component.new(env: env, parent: self, **attributes, &block)

            select = Presenters::DSL::Components::Select.new(parent: self,
                                                                id: 'account-type',
                                                                name: 'account_type')
            select.option("Checking")
            select.option("Savings")
            self << select
            self << Presenters::DSL::Components::TextField.new(parent: self,
                                                               id: 'account-name',
                                                               name: 'account_name')
            self << Presenters::DSL::Components::TextField.new(parent: self,
                                                               id: 'routing-number',
                                                               name: 'routing_number')
            self << Presenters::DSL::Components::TextField.new(parent: self,
                                                               id: 'account-number',
                                                               name: 'account_number')
          end
        end
        module WebClient
          def render_forte(comp,
                           render:,
                           components:,
                           index:)
            view_dir = File.join(__dir__, 'forte')
            render.call :erb, :forte, views: view_dir,
                        locals: {comp: comp,
                                 components: components, index: index}
          end
        end
      end
    end
  end
end
