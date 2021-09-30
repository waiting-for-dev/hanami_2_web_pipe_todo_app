# auto_register: false
# frozen_string_literal: true

require "web_pipe"
require "web_pipe/plugs/config"

WebPipe.load_extensions(
  :container,
  :flash,
  :hanami_view,
  :not_found,
  :params,
  :redirect,
  :router_params,
  :session,
  :url
)

module TodoManager
  class Action
    include WebPipe

    plug :config, WebPipe::Plugs::Config.(
      param_transformations: %i[router_params deep_symbolize_keys]
    )
  end
end
