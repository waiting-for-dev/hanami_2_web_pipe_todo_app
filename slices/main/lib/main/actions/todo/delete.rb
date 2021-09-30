# frozen_string_literal: true

require "web_pipe"

module Main
  module Actions
    module Todo
      class Delete
        include WebPipe
        include Deps[
          "application.repositories.todo_repo"
        ]

        compose :main, Main::Action.new

        plug :fetch_todo
        plug :transaction
        plug :render

        private

        def fetch_todo(conn)
          Action::FETCH_ENTITY_BY_ID.(todo_repo, :todo).(conn)
        end

        def transaction(conn)
          todo = conn.fetch(:todo)

          todo_repo.delete(todo.id) && conn
        end

        def render(conn)
          conn
            .add_flash(:success, 'Item successfully deleted')
            .redirect('/')
        end
      end
    end
  end
end
