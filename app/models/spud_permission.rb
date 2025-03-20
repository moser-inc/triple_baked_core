class SpudPermission

  attr_accessor :tag, :name, :apps

  def initialize(tag, name, apps=nil)
    self.tag = tag
    self.name = name
    self.apps = apps || []
  end

  # Find a permission by tag
  def self.find(tag)
    return TbCore.permissions.find{ |p| p.tag == tag }
  end

  # Returns hash of permissions, grouped by tag namespace
  def self.grouped_by_tag
    return TbCore.permissions.group_by do |p|
      p.tag.split('.').first
    end
  end

  # Returns array permissions sorted by tag
  def self.sorted_by_tag
    return TbCore.permissions.sort_by(&:tag)
  end

  # Returns all permissions
  def self.all
    return TbCore.permissions
  end

end
