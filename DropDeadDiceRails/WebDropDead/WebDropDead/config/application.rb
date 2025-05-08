require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WebDropDead
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # Load AutoDropDead files from folder
    config.autoload_paths += %W(#{config.root}/lib/drop_dead)

    # Explicitly load the load_drop_dead.rb file to run game
    require "#{Rails.root}/lib/drop_dead/load_drop_dead.rb"
  end
end
