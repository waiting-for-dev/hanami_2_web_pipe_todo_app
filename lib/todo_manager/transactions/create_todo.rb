# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

module TodoManager
  module Transactions
    class CreateTodo
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)
      include Deps[
        "validation.create_todo_contract",
        "repositories.todo_repo"
      ]

      def call(input)
        attributes = yield validate(input)
        create_todo(attributes)
      end

      private

      def validate(input)
        result = create_todo_contract.(input)
        if result.success?
          Success(result.to_h)
        else
          Failure(result)
        end
      end

      def create_todo(attributes)
        Success(
          todo_repo.create(attributes)
        )
      end
    end
  end
end
