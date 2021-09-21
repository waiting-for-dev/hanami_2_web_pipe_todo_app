# frozen_string_literal: true

require "dry/monads"
require "dry/schema"
require "web_pipe"

module Main
  module Actions
    module Todo
      class Create
        include WebPipe
        include Dry::Monads[:result]
        include Deps[
          "application.transactions.create_todo"
        ]

        SCHEMA = Dry::Schema.Params do
          required(:todo).hash do
            required(:title).maybe(:string)
            required(:description).maybe(:string)
          end
        end

        compose :main, Main::Action.new

        plug :sanitize_params, WebPipe::Plugs::SanitizeParams.(SCHEMA)
        plug :transaction
        plug :render

        private

        def transaction(conn)
          result = create_todo.(conn.sanitized_params[:todo])
          case result
          in Success
            conn
          in Failure[result]
            conn
              .view('views.todo.new', todo: result.to_h, errors: result.errors.to_h)
              .halt
          end
        end

        def render(conn)
          conn
            .add_flash(:success, 'Item created successfully')
            .redirect('/')
        end
      end
    end
  end
end
