# auto_register: false
# frozen_string_literal: true

require "app_prototype/action"
require "web_pipe"
require "web_pipe/plugs/config"
require "web_pipe/plugs/content_type"


module Main
  class Action
    include WebPipe

    compose :app_prototype, AppPrototype::Action.new

    plug :html, WebPipe::Plugs::ContentType.('text/html')

    plug :config, WebPipe::Plugs::Config.(
      container: AppPrototype::Application.slices[:main]
    )
  end
end
