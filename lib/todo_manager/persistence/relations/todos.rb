# frozen_string_literal: true

module Persistence
  module Relations
    class Todos < ROM::Relation[:sql]
      schema(:todos, infer: true)
    end
  end
end
