# frozen_string_literal: true

module Main
  module Views
    module Todo
      class Index < View::Base
        expose :todos

        private

        def title
          "List of Todo items"
        end
      end
    end
  end
end
