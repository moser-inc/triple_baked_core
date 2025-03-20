class AddRequiresPasswordChangeToSpudUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :spud_users, :requires_password_change, :boolean, :default => false
  end
end
