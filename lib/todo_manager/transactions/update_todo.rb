# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

module TodoManager
  module Transactions
    class UpdateTodo
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)
      include Deps[
        "validation.update_todo_contract",
        "repositories.todo_repo"
      ]

      def call(todo, input)
        attributes = yield validate(input)
        update_todo(todo, attributes)
      end

      private

      def validate(input)
        result = update_todo_contract.call(input)
        if result.success?
          Success(result.to_h)
        else
          Failure(result)
        end
      end

      def update_todo(todo, attributes)
        Success(
          todo_repo.update(todo.id, attributes)
        )
      end
    end
  end
end
