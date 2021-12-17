# frozen_string_literal: true

require "forme"

module Main
  module Views
    module Todo
      class Edit < View::Base
        expose :form
        private_expose :object
        private_expose :id

        private

        def title(object:)
          "Edit Todo \##{object[:id]}"
        end

        def form(object:, id:, context:)
          update_form(object: object, name: :todo, id: id, context: context) do |f|
            f.input(:title, label: 'Title')
            f.input(:description, label: 'Description', type: :textarea)
            f.button(value: 'Save', class: "btn btn-primary")
          end
        end
      end
    end
  end
end
