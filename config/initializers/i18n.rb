# frozen_string_literal: true

root_path = File.expand_path(__dir__)

I18n.load_path += Dir[File.join(root_path, 'config/locales/**/*.yml')]
I18n.available_locales = %i[en ru]
I18n.default_locale = :ru
