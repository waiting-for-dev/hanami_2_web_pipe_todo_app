# frozen_string_literal: true

module Main
  module Views
    module Todo
      class Index < View::Base
        expose :todos
      end
    end
  end
end
