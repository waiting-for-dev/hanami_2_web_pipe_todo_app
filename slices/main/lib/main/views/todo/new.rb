# frozen_string_literal: true

require "forme"

module Main
  module Views
    module Todo
      class New < View::Base
        expose :form
        private_expose :todo
        private_expose :errors

        private

        def title
          "Create a Todo item"
        end

        def form(todo:, errors: {}, context:)
          Forme.form({ method: :post, action: "/todos" }, { obj: todo, errors: { 'todo' => errors }, namespace: 'todo', hidden_tags: [{ context.csrf_field => context.csrf_token }] }) do |f|
            f.input(:title, error: errors[:title], label: 'Title')
            f.input(:description, label: 'Description', type: :textarea)
            f.button(value: 'Save', class: "btn btn-primary")
          end
        end
      end
    end
  end
end
