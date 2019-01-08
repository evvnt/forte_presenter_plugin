require_relative 'forte/component'
module Voom
  module Presenters
    module Plugins
      module Forte
        module DSLMethods
          def forte(**attributes, &block)
            if Rails && Rails.env
              env = Rails.env
            else
              env = 'development'
            self << Forte::Component.new(env: env, parent: self, **attributes, &block)
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