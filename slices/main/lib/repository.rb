# auto_register: false
# frozen_string_literal: true

require "todo_manager/repository"

module Main
  class Repository < TodoManager::Repository
    struct_namespace Entities
  end
end
