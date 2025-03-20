class SpudRole < ActiveRecord::Base

  has_many :spud_role_permissions, dependent: :destroy
  has_many :users, class_name: 'SpudUser', dependent: :nullify

  validates :name, presence: true, uniqueness: true

  def permissions
    self.spud_role_permissions.collect(&:permission).reject(&:blank?)
  end

  def permissions=(permissions_list)
    self.permission_tags = permissions_list.collect(&:tag)
  end

  def permission_tags=(tags)
    self.spud_role_permissions = tags.map do |tag|
      SpudRolePermission.new(spud_permission_tag: tag)
    end
  end

  def permission_tags
    return self.permissions.collect(&:tag)
  end

end
