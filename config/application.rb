require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module MedicalApp
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local
    config.action_view.embed_authenticity_token_in_remote_forms = true

    module Dansyalist
      class Application < Rails::Application
        config.i18n.default_locale = :ja
      end
    end
    config.generators do |g|
      g.test_framework :rspec,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end