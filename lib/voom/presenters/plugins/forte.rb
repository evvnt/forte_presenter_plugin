require_relative 'forte/forte_js_component'
module Voom
  module Presenters
    module Plugins
      module Forte
        module DSLMethods
          def forte_js(**attributes, &block)
            if defined?(Rails) && Rails.env
              env = Rails.env
            else
              env = 'development'
            end
            self << Forte::ForteJsComponent.new(env: env, parent: self, **attributes, &block)
          end

          def forte_echeck_form(**attributes, &block)
            form = Presenters::DSL::Components::Form.new(parent: self,
                                                          id: 'forte-echeck-form') do
              select = Presenters::DSL::Components::Select.new(parent: self,
                                                                  id: 'account-type',
                                                                  name: 'account_type')
              select.option("Checking", value: 'checking')
              select.option("Savings", value: 'savings')
              acct_name = Presenters::DSL::Components::TextField.new(parent: self,
                                                                     id: 'account-name',
                                                                     name: 'account_name')
              acct_name.label("Name on Account")

              rout_num = Presenters::DSL::Components::TextField.new(parent: self,
                                                                 id: 'routing-number',
                                                                 name: 'routing_number')
              rout_num.label("Routing Number")
              acct_num = Presenters::DSL::Components::TextField.new(parent: self,
                                                                 id: 'account-number',
                                                                 name: 'account_number')
              acct_num.label("Account Number")
              self << select
              self << acct_name
              self << rout_num
              self << acct_num

              button = Presenters::DSL::Components::Button.new(parent: self,
                                                               text: "Submit",
                                                               type: 'submit',
                                                               id: 'forte-echeck-form-submit',
                                                               name: 'forte_echeck_form_submit')
              button.event :click do
                # needs to activate some sort of event, which processes the input data
                #
                # then needs to call the Ruby command supplied to use the token to create a new permanent paymethod
                #
                # then needs to yield back to the block supplied, so that a snackbar or something can be shown
              end

              self << button
            end
            self << form
          end
        end

        module WebClient
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
      end
    end
  end
end
