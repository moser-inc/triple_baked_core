class DropSpudAdminPermissions < ActiveRecord::Migration[4.2]
  def up
    drop_table :spud_admin_permissions
  end

  def down
    create_table :spud_admin_permissions do |t|
      t.integer :user_id
      t.string :name
      t.boolean :access
      t.string :scope
      t.timestamps
    end
  end
end
