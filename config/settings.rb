# frozen_string_literal: true

require "todo_manager/types"
require "hanami/application/settings"

module TodoManager
  class Settings < Hanami::Application::Settings
    # Database
    setting :database_url, constructor: Types::String

    # Application
    setting :session_secret, constructor: Types::String

    # Assets
    setting :precompiled_assets, constructor: Types::Params::Bool, default: false
  end
end
