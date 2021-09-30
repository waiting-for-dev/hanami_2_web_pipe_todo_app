# frozen_string_literal: true

require "forme"
require "hanami/view"
require_relative "parts"

module Main
  module View
    class Base < Hanami::View
      class FormObject
        EMPTY_RESULT = Struct.new(:to_h, :errors).new({}, {})

        attr_reader :result, :id

        # @param result [Dry::Validation::Result, EmptyResult]
        # @param id [Integer]
        def initialize(result: EMPTY_RESULT, id: nil)
          @result = result
          @id = id
        end

        def values
          result.to_h
        end

        def errors
          result.errors.to_h
        end
      end

      # This will eventually be automatic via Hanami 2 view integration
      config.inflector = Hanami.application[:inflector]
      config.default_context = Main::View::Context.new

      config.part_namespace = Parts

      expose :title, layout: true

      private

      def creation_form(result,
                        resource,
                        context:,
                        method: :post,
                        action: "/#{inflector.pluralize(resource)}",
                        namespace: resource)
        object = FormObject.new(result: result)

        Forme.form(
          { method: method, action: action },
          {
            obj: object.values,
            errors: { namespace => object.errors },
            namespace: namespace,
            hidden_tags: [{ context.csrf_field => context.csrf_token }]
          }
        ) do |f|
          yield f
        end
      end

      def inflector
        Hanami.application[:inflector]
      end
    end
  end
end
