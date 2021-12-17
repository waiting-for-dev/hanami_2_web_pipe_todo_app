# frozen_string_literal: true

module Main
  module Validation
    class UpdateTodoContract < Contract
      schema do
        optional(:title).filled(:string)
        optional(:description).filled(:string)
      end
    end
  end
end
