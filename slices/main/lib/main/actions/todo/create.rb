# frozen_string_literal: true

require "dry/monads"
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

        compose :main, Main::Action.new

        plug :transaction
        plug :render

        private

        def transaction(conn)
          result = create_todo.(conn.params[:todo])

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
