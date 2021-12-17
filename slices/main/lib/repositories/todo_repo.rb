# frozen_string_literal: true

module Main
  module Repositories
    class TodoRepo < Repository[:todos]
      commands :create,
               update: :by_pk,
               delete: :by_pk

      def all
        todos.to_a
      end

      def by_id(id)
        todos.by_pk(id).one
      end
    end
  end
end
