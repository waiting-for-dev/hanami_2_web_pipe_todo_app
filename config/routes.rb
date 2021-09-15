# frozen_string_literal: true

require "hanami/application/routes"

module TodoManager
  class Routes < Hanami::Application::Routes
    define do
      slice :main, at: "/" do
        root to: "todo.index"
        get "/todos/:id", to: "todo.show"
      end
    end
  end
end
