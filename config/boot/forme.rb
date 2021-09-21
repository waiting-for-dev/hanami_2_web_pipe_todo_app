# frozen_string_literal: true

Hanami.application.register_bootable :forme do
  init do
    require "forme"
    require "forme/bs3"

    Forme.default_config = :bs3
  end
end


