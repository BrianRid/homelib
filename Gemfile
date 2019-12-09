source 'https://rubygems.org'
ruby '2.6.3'

# DEFAULTS
gem 'bootsnap', require: false
gem 'devise'
gem 'jbuilder', '~> 2.0'
gem 'pg', '~> 0.21'
gem 'puma'
gem 'rails', '5.2.3'
gem 'redis'
gem 'rails-i18n', '~> 5.1'
# OWN GEMS
gem 'cloudinary', '~> 1.12.0'
gem 'money-rails'
gem 'pundit'
gem 'wicked_pdf'
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
gem 'wkhtmltopdf-binary'

# ASSETS
gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'sassc-rails'
gem 'simple_form'
gem 'uglifier'
gem 'webpacker'

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'dotenv-rails'
  # added gem
  gem 'capybara'
  gem 'webdrivers', '~> 4.0'
  gem 'launchy'
end

group :production do
  gem 'wkhtmltopdf-heroku'
end
