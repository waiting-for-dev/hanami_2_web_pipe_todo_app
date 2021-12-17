# frozen_string_literal: true

require "rom-repository"
require_relative "entities"

module TodoManager
  class Repository < ROM::Repository::Root
    include Deps[container: "persistence.rom"]

    require_relative 'entities'

    struct_namespace Entities
  end
end
