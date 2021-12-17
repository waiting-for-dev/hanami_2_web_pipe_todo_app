# frozen_string_literal: true

require "web_pipe"

module Main
  module Actions
    module Todo
      class New
        include WebPipe

        compose :main, Main::Action.new

        plug :render

        private

        def render(conn)
          conn.view('views.todo.new')
        end
      end
    end
  end
end
