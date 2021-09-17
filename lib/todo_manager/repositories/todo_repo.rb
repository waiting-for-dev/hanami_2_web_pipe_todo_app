# frozen_string_literal: true

module TodoManager
  module Repositories
    class TodoRepo < Repository[:todos]
      commands :create

      def all
        todos.to_a
      end

      def by_id(id)
        todos.by_pk(id).one
      end
    end
  end
end
