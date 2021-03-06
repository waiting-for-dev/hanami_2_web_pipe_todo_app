# frozen_string_literal: true

require "web_pipe"

module Main
  module Actions
    module Todo
      class Show
        include WebPipe
        include Deps[
          "repositories.todo_repo"
        ]

        compose :main, Main::Action.new

        plug :fetch_todo
        plug :render

        private

        def fetch_todo(conn)
          Action::FETCH_ENTITY_BY_ID.(todo_repo, :todo).(conn)
        end

        def render(conn)
          todo = conn.fetch(:todo)

          conn.view('views.todo.show', todo: todo)
        end
      end
    end
  end
end
