# auto_register: false
# frozen_string_literal: true

require "todo_manager/action"
require "web_pipe"
require "web_pipe/plugs/config"
require "web_pipe/plugs/content_type"

module Main
  class Action
    include WebPipe

    compose :todo_manager, TodoManager::Action.new

    plug :html, WebPipe::Plugs::ContentType.('text/html')
    plug :config, WebPipe::Plugs::Config.(
      container: TodoManager::Application.slices[:main]
    )
  end
end
