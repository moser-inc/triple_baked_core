class AddScopeToSpudAdminPermissions < ActiveRecord::Migration[4.2]
  def change
    add_column :spud_admin_permissions, :scope, :string

  end
end
