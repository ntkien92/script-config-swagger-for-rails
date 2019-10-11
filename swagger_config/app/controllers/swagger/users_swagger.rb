# frozen_string_literal: true

class Swagger::UsersSwagger
  include Swagger::Blocks

  swagger_schema :User do
    key :required, %i[id type attributes]
    property :id do
      key :type, :integer
      key :example, 1
    end
    property :type do
      key :type, :string
      key :example, 'user'
    end
    property :attributes do
      key :required, %i[email]
      property :email do
        key :type, :string
        key :example, 'user1@example.com'
      end
    end
  end

  swagger_path '/api/users' do
    operation :post do
      key :description, 'xxx'
      key :tags, ['user']
      key :produces, [
        'application/json',
      ]

      parameter name: :user do
        key :in, :body
        schema do
          key :'$ref', :User
        end
      end

      response 200 do
        key :description, '200 OK'
        schema do
          key :required, [:data]
          property :data do
            key :'$ref', :User
          end
        end
      end
    end
  end

  swagger_path '/api/users' do
    operation :put do
      key :description, 'Update Password'
      key :tags, ['user']
      key :produces, [
        'application/json',
      ]

      parameter name: :user do
        key :in, :body
        schema do
          key :'$ref', :User
        end
      end

      response 200 do
        key :description, 'Success'
      end
    end
  end
end
