# frozen_string_literal: true

require "web_pipe"

module Main
  module Actions
    module Todo
      class Show
        include WebPipe
        include Deps[
          "application.repositories.todo_repo"
        ]

        compose :main, Main::Action.new

        plug :fetch_todo
        plug :check_todo
        plug :render

        private

        def fetch_todo(conn)
          todo = todo_repo.by_id(conn.params[:id])

          conn.add(:todo, todo)
        end

        def check_todo(conn)
          conn.fetch(:todo) ? conn : conn.not_found
        end

        def render(conn)
          todo = conn.fetch(:todo)

          conn.view('views.todo.show', todo: todo)
        end
      end
    end
  end
end
