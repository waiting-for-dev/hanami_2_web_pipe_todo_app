# frozen_string_literal: true

require "forme"

module Main
  module Views
    module Todo
      class Edit < View::Base
        expose :form
        private_expose :id
        private_expose :todo
        private_expose :errors

        private

        def title(id:)
          "Edit Todo \##{id}"
        end

        def form(id:, todo:, errors: {}, context:)
          Forme.form({ method: :post, action: "/todos/#{id}" }, { obj: todo, errors: { 'todo' => errors }, namespace: 'todo', hidden_tags: [{ context.csrf_field => context.csrf_token, "_method" => "PATCH" }] }) do |f|
            f.input(:title, label: 'Title')
            f.input(:description, label: 'Description', type: :textarea)
            f.button(value: 'Save', class: "btn btn-primary")
          end
        end
      end
    end
  end
end
