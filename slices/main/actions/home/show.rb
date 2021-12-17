# frozen_string_literal: true

require "web_pipe"

module Main
  module Actions
    module Home
      class Show
        include WebPipe

        compose :main, Main::Action.new

        plug :render do |conn|
          conn.view('views.home.show')
        end
      end
    end
  end
end
