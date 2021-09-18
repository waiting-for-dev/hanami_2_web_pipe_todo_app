# auto_register: false
# frozen_string_literal: true

require "rack/csrf"
require "rack-flash"
require "rack/session/cookie"
require "web_pipe"
require "web_pipe/plugs/config"

WebPipe.load_extensions(
  :container,
  :dry_schema,
  :flash,
  :hanami_view,
  :params,
  :redirect,
  :router_params,
  :session,
  :url
)

module TodoManager
  class Action
    include WebPipe

    use :session, Rack::Session::Cookie,
        key: "todo_manager.session",
        secret: TodoManager::Application.settings["session_secret"],
        expire_after: 60 * 60 * 24 * 365 # 1 year
    use :csrf_protection, Rack::Csrf, raise: true
    use :flash, Rack::Flash

    plug :config, WebPipe::Plugs::Config.(
      param_transformations: [:router_params, :deep_symbolize_keys],
      param_sanitization_handler: lambda do |conn, _result|
        conn
          .set_status(422)
          .set_response_body('Malformed params')
          .halt
      end,
      view_context: lambda do |conn|
        {
          current_path: conn.full_path,
          csrf_token: Rack::Csrf.token(conn.env),
          csrf_field: Rack::Csrf.field,
          flash: conn.flash
        }
      end
    )
  end
end
