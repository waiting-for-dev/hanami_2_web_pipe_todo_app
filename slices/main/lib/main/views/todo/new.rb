# frozen_string_literal: true

module Main
  module Views
    module Todo
      class New < View::Base
        expose :form
        private_expose :result

        private

        def title
          "Create a Todo item"
        end

        def form(result: FormObject::EMPTY_RESULT, context:)
          creation_form(result, :todo, context: context) do |f|
            f.input(:title, label: 'Title')
            f.input(:description, label: 'Description', type: :textarea)
            f.button(value: 'Save', class: "btn btn-primary")
          end
        end
      end
    end
  end
end
