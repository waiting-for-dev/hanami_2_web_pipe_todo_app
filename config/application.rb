# frozen_string_literal: true

begin
  require "break"
rescue LoadError => e
  raise unless e.path == "break"
end

require "hanami"

module TodoManager
  class Application < Hanami::Application
    config.logger.options[:level] = :debug
    config.logger.options[:stream] = settings.log_to_stdout ? $stdout : "log/#{Hanami.env}.log"
  end
end
