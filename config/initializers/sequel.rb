# frozen_string_literal: true

# Sequel.connect("sqlite://#{Settings.db.database}.db")
Sequel.connect(Settings.db.to_hash)

Sequel::Model.db.extension(:pagination)

Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :timestamps, update_on_create: true

Sequel.default_timezone = :utc