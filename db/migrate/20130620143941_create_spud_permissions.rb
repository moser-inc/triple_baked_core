class CreateSpudPermissions < ActiveRecord::Migration[4.2]
  def change
    create_table :spud_permissions do |t|
      t.string :name, :null => false
      t.string :tag, :null => false
      t.timestamps
    end
    add_index :spud_permissions, :tag, :unique => true
  end
end
