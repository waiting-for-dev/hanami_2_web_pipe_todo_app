# auto_register: false
# frozen_string_literal: true

require "web_pipe"
require "web_pipe/plugs/config"

WebPipe.load_extensions(
  :container,
  :dry_schema,
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
      param_transformations: [:router_params, :deep_symbolize_keys],
      param_sanitization_handler: lambda do |conn, _result|
        conn
          .set_status(422)
          .set_response_body('Malformed params')
          .halt
      end
    )
  end
end
