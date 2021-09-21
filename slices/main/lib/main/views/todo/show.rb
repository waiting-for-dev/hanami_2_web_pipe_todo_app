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
          Forme.form({ method: :post, action: "/todos/#{todo.id}" }, { hidden_tags: [{ context.csrf_field => context.csrf_token, "_method" => "DELETE" }] }) do |f|
            f.button({ value: 'Delete', class: "btn btn-danger pull-right" })
          end
        end
      end
    end
  end
end
