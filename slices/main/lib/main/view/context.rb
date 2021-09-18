# frozen_string_literal: true

module Main
  module View
    class Context < TodoManager::View::Context
      def current_path
        self[:current_path]
      end

      def csrf_token
        self[:csrf_token]
      end

      def csrf_tag(form)
        form.input(:hidden, name: csrf_field, value: csrf_token)
      end

      def flash
        self[:flash]
      end

      def csrf_field
        self[:csrf_field]
      end
    end
  end
end
