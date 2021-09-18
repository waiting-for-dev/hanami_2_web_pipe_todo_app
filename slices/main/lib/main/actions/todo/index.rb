# frozen_string_literal: true

require "web_pipe"

module Main
  module Actions
    module Todo
      class Index
        include WebPipe
        include Deps[
          "application.repositories.todo_repo"
        ]

        compose :main, Main::Action.new

        plug :fetch_todos
        plug :render

        private

        def fetch_todos(conn)
          conn
            .add(:todos, todo_repo.all)
        end

        def render(conn)
          conn
            .view('views.todo.index', todos: conn.fetch(:todos))
        end
      end
    end
  end
end
