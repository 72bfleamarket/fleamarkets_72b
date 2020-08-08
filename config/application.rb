require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)


module FleamarketSample72b
  class Application < Rails::Application
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.yml").to_s]
    config.action_view.automatically_disable_submit_tag = false
    config.action_view.field_error_proc = proc { |html_tag, instance| html_tag }
  end
end