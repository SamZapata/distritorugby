class AddRolesAndProfileUserForeignKey < ActiveRecord::Migration[7.1]
  def up
    invalid_profile_user_ids = select_value(<<~SQL).to_i
      SELECT COUNT(*)
      FROM profiles AS profiles
      WHERE profiles.user_id IS NOT NULL
        AND (
          profiles.user_id !~ '^[0-9]+$'
          OR CASE
            WHEN profiles.user_id ~ '^[0-9]+$' THEN
              profiles.user_id::numeric > 9223372036854775807
              OR NOT EXISTS (
                SELECT 1
                FROM users
                WHERE users.id::numeric = profiles.user_id::numeric
              )
            ELSE TRUE
          END
        )
    SQL

    if invalid_profile_user_ids.positive?
      raise ActiveRecord::MigrationError,
            "Cannot convert profiles.user_id: #{invalid_profile_user_ids} values are invalid or reference missing users"
    end

    change_column :profiles, :user_id, :bigint, using: 'user_id::bigint'
    add_foreign_key :profiles, :users
    add_column :users, :role, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :role
    remove_foreign_key :profiles, :users
    change_column :profiles, :user_id, :string, using: 'user_id::text'
  end
end
