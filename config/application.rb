require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DddCrm
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << "#{Rails.root}/app/commands"
    config.autoload_paths << "#{Rails.root}/app/entities"
    config.autoload_paths << "#{Rails.root}/app/queries"
    config.autoload_paths << "#{Rails.root}/app/repositories"
    config.autoload_paths << "#{Rails.root}/app/services"
    config.autoload_paths << "#{Rails.root}/app/events"
  end
end
