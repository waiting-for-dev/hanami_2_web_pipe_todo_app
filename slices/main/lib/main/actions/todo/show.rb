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
          conn
            .add(:todo, todo_repo.by_id(conn.params[:id]))
        end

        def check_todo(conn)
          if conn.fetch(:todo)
            conn
          else
            conn
              .set_status(404)
              .set_response_body('Not found')
              .halt
          end
        end

        def render(conn)
          conn
            .view('views.todo.show', todo: conn.fetch(:todo))
        end
      end
    end
  end
end
