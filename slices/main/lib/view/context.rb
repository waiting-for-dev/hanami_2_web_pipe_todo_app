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

      def flash
        self[:flash]
      end

      def flash_success?
        self[:flash_success?]
      end

      def csrf_field
        self[:csrf_field]
      end
    end
  end
end
