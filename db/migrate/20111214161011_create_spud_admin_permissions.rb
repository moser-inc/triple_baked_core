class CreateSpudAdminPermissions < ActiveRecord::Migration[4.2]
  def change
    create_table :spud_admin_permissions do |t|
      t.integer :user_id
      t.string :name
      t.boolean :access

      t.timestamps
    end
  end
end
