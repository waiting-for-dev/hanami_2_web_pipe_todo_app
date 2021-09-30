# frozen_string_literal: true

require "dry/monads"
require "web_pipe"

module Main
  module Actions
    module Todo
      class Update
        include Dry::Monads[:result]
        include WebPipe
        include Deps[
          "application.transactions.update_todo",
          "application.repositories.todo_repo"
        ]

        compose :main, Main::Action.new

        plug :fetch_todo
        plug :check_todo
        plug :transaction
        plug :render

        private

        def fetch_todo(conn)
          todo = todo_repo.by_id(conn.params[:id])

          conn.add(:todo, todo)
        end

        def check_todo(conn)
          conn.fetch(:todo) ? conn : conn.not_found
        end

        def transaction(conn)
          todo = conn.fetch(:todo)
          result = update_todo.(todo, conn.params[:todo])

          case result
          in Success
            conn
          in Failure[result]
            conn
              .view('views.todo.edit', id: todo.id, todo: result.to_h, errors: result.errors.to_h)
              .halt
          end
        end

        def render(conn)
          conn
            .add_flash(:success, 'Item updated successfully')
            .redirect('/')
        end
      end
    end
  end
end
