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
          todos = todo_repo.all

          conn.add(:todos, todos)
        end

        def render(conn)
          todos = conn.fetch(:todos)

          conn.view('views.todo.index', todos: todos)
        end
      end
    end
  end
end
