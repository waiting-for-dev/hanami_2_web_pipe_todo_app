# frozen_string_literal: true

require "dry/monads"
require "dry/schema"
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

        SCHEMA = Dry::Schema.Params do
          required(:id).filled(:integer)
          required(:todo).hash do
            required(:title).maybe(:string)
            required(:description).maybe(:string)
          end
        end

        compose :main, Main::Action.new

        plug :sanitize_params, WebPipe::Plugs::SanitizeParams.(SCHEMA)
        plug :fetch_todo
        plug :check_todo
        plug :transaction
        plug :render

        private

        def fetch_todo(conn)
          conn
            .add(:todo, todo_repo.by_id(conn.sanitized_params[:id]))
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

        def transaction(conn)
          todo = conn.fetch(:todo)

          result = update_todo.(todo, conn.sanitized_params[:todo])
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
