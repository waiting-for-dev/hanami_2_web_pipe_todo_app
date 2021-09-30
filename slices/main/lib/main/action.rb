# auto_register: false
# frozen_string_literal: true

require "rack/csrf"
require "rack-flash"
require "rack/session/cookie"
require "todo_manager/action"
require "web_pipe"
require "web_pipe/plugs/config"
require "web_pipe/plugs/content_type"

module Main
  class Action
    include WebPipe

    FETCH_ENTITY_BY_ID = lambda do |repo, name, id: :id|
      lambda do |conn|
        entity = repo.by_id(conn.params[id])
        entity ? conn.add(name, entity) : conn.not_found
      end
    end.freeze

    compose :todo_manager, TodoManager::Action.new

    use :session, Rack::Session::Cookie,
        key: "todo_manager.session",
        secret: TodoManager::Application.settings["session_secret"],
        expire_after: 60 * 60 * 24 * 365 # 1 year
    use :csrf_protection, Rack::Csrf, raise: true
    use :flash, Rack::Flash

    plug :html, WebPipe::Plugs::ContentType.('text/html')
    plug :config, WebPipe::Plugs::Config.(
      container: TodoManager::Application.slices[:main],
      view_context: lambda do |conn|
        {
          current_path: conn.full_path,
          csrf_token: Rack::Csrf.token(conn.env),
          csrf_field: Rack::Csrf.field,
          flash: conn.flash,
          flash_success?: !conn.flash[:success].nil?
        }
      end
    )
  end
end
