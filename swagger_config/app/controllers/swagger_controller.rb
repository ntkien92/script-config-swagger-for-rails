# frozen_string_literal: true

class SwaggerController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'XXX Application API'
    end
    key :consumes, ['application/json']
    key :produces, ['application/json']
    security_definition :auth_key do
      key :type, :apiKey
      key :name, ENV.fetch('AUTH_HEADER_NAME') { 'Authorization' }
      key :in, :header
      key :description, <<-"EOS"
        The value for the Authorization header is expected to have the prefix<br />
        "Token" or "Bearer". <br />
        If the header looks like this: <br />
        #{ENV.fetch('AUTH_HEADER_NAME') { 'Authorization' }}: Token token=abc
      EOS
    end
  end
  swagger_schema :ErrorModel do
    property :errors do
      key :type, :array
      items do
        key :required, %i[pointer title]
        property :pointer do
          key :type, :string
          key :example, '/data/attributes/email'
        end
        property :title do
          key :type, :string
          key :example, 'Email has already been taken'
        end
      end
    end
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    Swagger::UsersSwagger,
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
