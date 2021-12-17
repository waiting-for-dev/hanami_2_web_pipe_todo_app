# auto_register: false
# frozen_string_literal: true

require "forme"
require "hanami/view"

module Main
  module View
    class Base < Hanami::View
      include Forms

      # This will eventually be automatic via Hanami 2 view integration
      config.inflector = Hanami.application[:inflector]
      config.default_context = Main::View::Context.new

      expose :title, layout: true
    end
  end
end
