# frozen_string_literal: true

module Main
  module View
    # Quick & dirty integration between dry-validation, rom entities and forme.
    # It needs more work.
    module Forms
      class FormObject
        EMPTY_OBJECT = Struct.new(:to_h, :errors).new({}, {})

        attr_reader :object

        # @param object [Dry::Validation::Result, ROM::Struct, EMPTY_OBJECT]
        def initialize(object: EMPTY_OBJECT)
          @object = object
        end

        def values
          object.to_h
        end

        def errors
          if object.is_a?(Dry::Validation::Result)
            object.errors.to_h
          else
            {}
          end
        end
      end

      def creation_form(object:,
                        context:,
                        name: nil,
                        method: :post,
                        action: "/#{inflector.pluralize(name)}",
                        namespace: name)
        object = FormObject.new(object: object)

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

      def update_form(object:,
                      context:,
                      name: nil,
                      id: nil,
                      method: :patch,
                      action: "/#{inflector.pluralize(name)}/#{id}",
                      namespace: name)
        object = FormObject.new(object: object)

        Forme.form(
          { method: :post, action: action },
          {
            obj: object.values,
            errors: { namespace => object.errors },
            namespace: namespace,
            hidden_tags: [{ context.csrf_field => context.csrf_token, "_method" => method.to_s.upcase }]
          }
        ) do |f|
          yield f
        end
      end

      def delete_form(entity:,
                      context:,
                      name: nil,
                      action: "/#{inflector.pluralize(name)}/#{entity.id}")
        Forme.form(
          { method: :post, action: action },
          { hidden_tags: [{ context.csrf_field => context.csrf_token, "_method" => "DELETE" }] }
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
