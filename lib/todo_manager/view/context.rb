# frozen_string_literal: true

require "hanami/view/context"

module TodoManager
  module View
    class Context < Hanami::View::Context
      include Deps[
        "assets",
        "settings"
      ]

      def initialize(**args)
        defaults = {content: {}}

        super(**defaults.merge(args))
      end

      def content_for(key, value = nil, &block)
        content = _options[:content]
        output = nil

        if block
          content[key] = yield
        elsif value
          content[key] = value
        else
          output = content[key]
        end

        output
      end

      private

      def [](key)
        _options.fetch(key)
      end
    end
  end
end
