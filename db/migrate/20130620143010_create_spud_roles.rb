class CreateSpudRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :spud_roles do |t|
      t.string :name
      t.timestamps
    end
    add_column :spud_users, :spud_role_id, :integer
    add_index :spud_users, :spud_role_id
  end
end
