# frozen_string_literal: true

namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |_t, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      byebug
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      # system("sequel -D postgresql://#{Settings.db.user}@#{Settings.db.host}/#{Settings.db.database} > db/schema.rb")
    end
  end
end
