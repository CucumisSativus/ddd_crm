source 'https://rubygems.org'


gem 'rails', '>= 5.0.0.beta3', '< 5.1'
gem 'sqlite3'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'rails_event_store'
gem 'devise', git: 'git@github.com:plataformatec/devise.git'
gem 'haml'
gem 'react-rails', '~> 1.6.0'
gem 'virtus'
gem 'active_model_serializers'

group :development, :test do
  gem 'byebug'
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
  end
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  gem 'quiet_assets'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
