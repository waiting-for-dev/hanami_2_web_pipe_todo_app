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

        def form(id:, todo:, errors: {}, context:)
          Forme.form({ method: :post, action: "/todos/#{id}" }, { obj: todo, errors: { 'todo' => errors }, namespace: 'todo', hidden_tags: [{ context.csrf_field => context.csrf_token, "_method" => "PATCH" }] }) do |f|
            # context.csrf_tag(f)
            f.input(:title, label: 'Title')
            f.input(:description, label: 'Description', type: :textarea)
            f.button 'Save'
          end
        end
      end
    end
  end
end
