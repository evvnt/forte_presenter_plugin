require_relative 'forte/forte_js_component'
require_relative 'forte/create_forte_token'

module Voom
  module Presenters
    module Plugins
      module Forte
        @@api_login_id = nil
        def self.set_api_login_id(x)
          @@api_login_id = x
        end
        def self.api_login_id
          @@api_login_id
        end

        module DSLHelpers
          def set_forte_api_login_id(id)
            Plugins::Forte.set_api_login_id(id)
          end
        end

        module DSLComponents
          def forte_js(**attributes, &block)
            env = (defined?(Rails) && Rails.env) || 'development'
            self << Forte::ForteJsComponent.new(env: env, parent: self, **attributes, &block)
          end

          def forte_echeck_form(url:, **attributes, &block)
            select id: 'forte-echeck-account-type', name: 'account_type' do
              option("Checking", value: 'c')
              option("Savings", value: 's')
            end
            text_field id: 'forte-echeck-account-name', name: 'account_name', autocomplete: 'off' do
              label "Name on Account"
            end
            text_field id: 'forte-echeck-routing-number', name: 'routing_number', autocomplete: 'off' do
              label "Routing Number"
            end
            text_field id: 'forte-echeck-account-number', name: 'account_number', autocomplete: 'off' do
              label "Account Number"
            end

            button text: "Submit", id: 'forte-echeck-form-submit', name: 'forte_echeck_form_submit' do
              event :click do
                create_forte_token api_login_id: Forte.api_login_id
                #snackbar last_response.token
                posts url, onetime_token: last_response.token
                yield_to(&block)
              end
            end
          end
        end

        module DSLEventActions
          def create_forte_token(**attributes, &block)
            self << Forte::CreateForteToken.new(parent: self, **attributes, &block)
          end
        end

        module WebClientComponents
          def render_forte_js(comp,
                             render:,
                             components:,
                             index:)
            view_dir = File.join(__dir__, 'forte')
            render.call :erb, :forte_js, views: view_dir,
                        locals: {comp: comp,
                                 components: components, index: index}
          end
        end

        module WebClientActions
          def action_data_create_forte_token(action, _parent_id, *)
            # Type, URL, Options, Params (passed into javascript event/action classes)
            ['createForteToken', action.url, action.options.to_h, action.attributes.to_h]
          end
        end
      end
    end
  end
end


