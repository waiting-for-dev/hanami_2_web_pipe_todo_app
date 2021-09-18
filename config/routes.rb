# frozen_string_literal: true

require "hanami/application/routes"

module TodoManager
  class Routes < Hanami::Application::Routes
    define do
      slice :main, at: "/" do
        root to: "todo.index"
        get "/todos/new", to: "todo.new"
        get "/todos/:id", to: "todo.show"
        get "/todos/:id/edit", to: "todo.edit"
        patch "/todos/:id", to: "todo.update"
        post "/todos", to: "todo.create"
        delete "/todos/:id", to: "todo.delete"
      end
    end
  end
end
