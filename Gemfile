source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

#                 CONEX-ET GEMS

# Use postgresql as the database for Active Record
gem 'pg'

# devise for authentication
gem 'devise'
# Seguridad añadida a devise
gem 'devise_security_extension'

#captcha
gem 'recaptcha', :require => "recaptcha/rails"

group :development do

  gem 'better_errors'
  gem 'binding_of_caller'

  #revisar en çonfig/environments/development.rb
  #correo en http://127.0.0.1:1080
  gem 'mailcatcher'

  #comenta modelos con campos
  gem 'annotate'

  ### LIVERELOADING
  gem 'guard'

  gem 'guard-livereload'

  ##HTML A HAML GEM
  gem 'html2haml'

  #graph workflow
  gem 'ruby-graphviz'
end


group :assets do
  gem 'jquery-ui-rails' # jquery ui

end


gem 'haml'
#roles y permisos
gem 'cancan'

#iconos
gem 'font-icons-rails', :git=> 'git://github.com/shorelabs/font-icons-rails.git'
gem 'font-awesome-rails'

#Para evitar que la aplicacion se quede esperando si no consigue
# javascript
gem 'jquery-turbolinks'

#subida de archivos
gem 'carrierwave'
gem 'rmagick', '~> 2.13.4'

###FULL TEXT SEARCH EN POSTGRESQL
gem 'pg_search'

###PAGINACION
gem 'kaminari'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Genera PDFs
gem 'prawn', '~> 1.3.0'

# Crea tablas dentro de los reportes
gem 'prawn-table', '~> 0.2.1'


# Carga de documentos paginados
gem 'jquery-fileupload-rails'

# GENERACION DE CODIGOS DE BARRA
gem 'barby'
gem 'chunky_png'

#archivos remotos
gem 'remotipart', '~> 1.2'

#active jobs
gem 'delayed_job_active_record'