# frozen_string_literal: true

require "forme"

module Main
  module Views
    module Todo
      class Show < View::Base
        expose :todo
        expose :delete_form

        private

        def title(todo:)
          "Todo \##{todo.id}"
        end

        def delete_form(todo:, context:)
          super(entity: todo, name: :todo, context: context) do |f|
            f.button({ value: 'Delete', class: "btn btn-danger pull-right" })
          end
        end
      end
    end
  end
end
