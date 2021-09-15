# frozen_string_literal: true

module TodoManager
  module Repositories
    class TodoRepo < Repository[:todos]
      def all
        todos.to_a
      end
    end
  end
end
