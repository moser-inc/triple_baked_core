class AddTimeZoneToSpudUser < ActiveRecord::Migration[4.2]
  def change
    add_column :spud_users, :time_zone, :string

  end
end
