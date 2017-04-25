require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Deputizeamerica
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Load in Async Workers
    # config.eager_load_paths += ["#{config.root}/lib/workers"]

    # Set Logging for Puma Server
    config.logger = Logger.new STDOUT

    # Emails
    ActionMailer::Base.smtp_settings = {
      address:               'smtp.sendgrid.net',
      port:                  '587',
      authentication:        :plain,
      user_name:             ENV['SENDGRID_USERNAME'],
      password:              ENV['SENDGRID_PASSWORD'],
      domain:                'deputizeamerica.org',
      enable_starttls_auto:  true
    }
    config.action_mailer.delivery_method = :smtp

    # Custom Asset Folders
    config.assets.enabled = true
    config.assets.paths << Rails.root.join("app", "assets", "videos")

  end
end
