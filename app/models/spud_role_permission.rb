class SpudRolePermission < ActiveRecord::Base
  belongs_to :spud_role

  def permission
    SpudPermission.find(self.spud_permission_tag)
  end

end
