# frozen_string_literal: true

module Main
  module Validation
    class CreateTodoContract < Contract
      schema do
        required(:title).filled(:string)
        required(:description).filled(:string)
      end
    end
  end
end
