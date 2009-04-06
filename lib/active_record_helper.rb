class ActiveRecordHelper
  class << self
    def recreate_database!
      migrations_path = Merb.root / "schema" / "migrations"

      load_schema = lambda {
        ActiveRecord::Migrator.down(migrations_path, 0)
        ActiveRecord::Migrator.migrate(migrations_path)
      }
      silence_stream(STDOUT, &load_schema)
    end
  end
end