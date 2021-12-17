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
          "transactions.create_todo"
        ]

        compose :main, Main::Action.new

        plug :transaction
        plug :render

        private

        def transaction(conn)
          case create_todo.(conn.params[:todo])
          in Success
            conn
          in Failure[result]
            conn
              .view('views.todo.new', object: result)
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
