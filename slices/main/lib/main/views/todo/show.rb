# frozen_string_literal: true

require "forme"

module Main
  module Views
    module Todo
      class Show < View::Base
        expose :todo
        expose :delete_form

        def delete_form(todo:, context:)
          Forme.form({ method: :post, action: "/todos/#{todo.id}" }, { hidden_tags: [{ context.csrf_field => context.csrf_token, "_method" => "DELETE" }] }) do |f|
            # context.csrf_tag(f)
            f.button 'Delete'
          end
        end
      end
    end
  end
end
