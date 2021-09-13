# auto_register: false
# frozen_string_literal: true

require "rack/csrf"
require "rack/session/cookie"
require "web_pipe"
require "web_pipe/plugs/config"

WebPipe.load_extensions(:hanami_view, :container, :url, :session)

module TodoManager
  class Action
    include WebPipe

    use :session, Rack::Session::Cookie,
        key: "todo_manager.session",
        secret: TodoManager::Application.settings["session_secret"],
        expire_after: 60 * 60 * 24 * 365 # 1 year

    use :csrf_protection, Rack::Csrf, raise: true

    plug :config, WebPipe::Plugs::Config.(
      view_context: lambda do |conn|
        {
          current_path: conn.full_path,
          csrf_token: Rack::Csrf.token(conn.env)
        }
      end
    )
  end
end
