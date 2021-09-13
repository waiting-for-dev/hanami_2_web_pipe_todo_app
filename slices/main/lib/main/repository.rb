# frozen_string_literal: true

require "todo_manager/repository"
require_relative "entities"

module Main
  class Repository < TodoManager::Repository
    struct_namespace Entities
  end
end
