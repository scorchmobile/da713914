# Ruby Version
ruby '2.3.3'

# Bower Package Hosting
source 'https://rails-assets.org' do

  # For bootstrap
  gem 'rails-assets-tether', '>= 1.1.0'
  gem 'rails-assets-bootstrap-switch', '~> 3.3.2'

end


# Ruby Gem Hosting
source 'https://rubygems.org' do

  # Redis
  gem 'redis', '~> 3.3', '>= 3.3.2'         #https://github.com/redis/redis-rb
  gem 'redis-rails', '~> 5.0', '>= 5.0.1'   #https://github.com/redis-store/redis-rails
  gem 'redis-rack-cache', '~> 2.0'          #https://github.com/redis-store/redis-rack-cache

  # XML to JSON
  gem 'crack', '~> 0.4.3'
  # XML Creator is Builder::XmlMarkup

  # Payment
  gem 'authorizenet', '~> 1.8.9.1'

  # HTTP Calls
  gem 'httparty', '~> 0.14.0'

  # WYSIWYG
  gem 'tinymce-rails', '~> 4.4', '>= 4.4.3'

  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '~> 5.0.1'

  # Use postgresql as the database for Active Record
  gem 'pg', '~> 0.18.4'

  # Use Puma as the app server
  gem 'puma', '~> 3.4.0'

  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 5.0.6'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 3.0.0'

  # File Uploading and Image Manipulation
  gem "carrierwave", "~> 0.10.0"
  gem 'carrierwave-aws', "~> 1.0.0"
  gem "unf", "~> 0.1.4"
  gem "mini_magick", "~> 4.3.6"

  # Image Optimization
  gem 'carrierwave-imageoptimizer', '~> 1.2.1'
  gem 'sprockets-image_compressor', '~> 0.3.0'

  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.2.1'

  # Use jquery as the JavaScript library
  gem 'jquery-rails', '~> 4.1.1'
  gem 'jquery-ui-rails', '~> 5.0.5'

  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
  gem 'turbolinks', '~> 5'

  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.5'

  # ENV Variables
  gem 'figaro', '~> 1.1.1'

  # Fastest JSON Parser
  gem "oj", "~> 2.17.1"

  # Styling and Layouts
  gem 'bootstrap-sass', '~> 3.3.6'

  # Forms made Easy
  gem "simple_form", "~> 3.2.1"

  # Font Awesome
  gem "font-awesome-rails", "~> 4.6.3.1"

  # Authentication and Omniauth
  gem "devise", "~> 4.2.0"

  # Security Checks
  gem "brakeman", "~> 3.3.2", group: :development

  # Queued Jobs (Not Compatible with 5) b/c of sinatra ~> 1.4.7
  #gem 'sidekiq', '~> 4.1.4'

  group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', '~> 9.0.5', platform: :mri
  end

  group :development do
    # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
    gem 'web-console', '~> 3.3.1'
    gem 'listen', '~> 3.1.5'
    # Errors
    gem "better_errors", "~> 2.1.1"
    gem "binding_of_caller", "~> 0.7.2"
    gem "meta_request", "~> 0.4.0"
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring', '~> 1.7.2'
    gem 'spring-watcher-listen', '~> 2.0.0'
    # For Eager Loading
    gem 'guard', '~> 2.14.0'
    gem 'guard-rails', '~> 0.7.2'
    gem 'guard-bundler', '~> 2.1.0', require: false
    # Testing
    gem "rspec-rails", "~> 3.5.1"
    gem "guard-rspec", "~> 4.7.2"
    gem "cucumber", "~> 2.4.0"
    gem "capybara", "~> 2.7.1"
    gem "poltergeist", "~> 1.10.0"
    gem "phantomjs", "~> 2.1.1.0", require: 'phantomjs/poltergeist'
    gem 'factory_girl', '~> 4.7.0'
  end

  group :production do
    # Serve GZipped Assets
    gem 'heroku-deflater', '~> 0.6.2'
    # Skip Plugin Injection
    gem "rails_12factor", "~> 0.0.3"
  end

  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  gem 'tzinfo-data', '~> 1.2016.6', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

end
