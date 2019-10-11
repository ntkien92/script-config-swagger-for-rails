#!/bin/bash

echo "Create file for Folder $1"


cp swagger_config/app/controllers/swagger_controller.rb $1/app/controllers
mkdir $1/app/controllers/swagger
cp swagger_config/app/controllers/swagger/users_swagger.rb $1/app/controllers/swagger/users_swagger.rb
mkdir $1/docs
cp swagger_config/docs/swagger.json $1/docs/swagger.json

cp swagger_config/config/initializers/swagger_ui_engine.rb $1/config/initializers/swagger_ui_engine.rb

declare -i MY_MESSAGE=`grep -n "end" $1/config/routes.rb | grep -Eo '^[^:]+' | tail -1`

sed -i '' "${MY_MESSAGE}i\\
mount SwaggerUiEngine::Engine, at: '/api_docs'
" $1/config/routes.rb

sed -i '' "${MY_MESSAGE}i\\
resources :swagger, only: [:index]
" $1/config/routes.rb

echo "" >> $1/Gemfile
echo "# API documentation" >> $1/Gemfile
echo "gem 'swagger-blocks'" >> $1/Gemfile
echo "gem 'swagger_ui_engine'" >> $1/Gemfile
