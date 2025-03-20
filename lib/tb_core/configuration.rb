module TbCore
  include ActiveSupport::Configurable
  config_accessor :site_name, :admin_applications, :from_address, :site_id, :short_name,
    :javascripts, :stylesheets, :admin_javascripts, :admin_stylesheets,
    :permissions, :production_alert_domain, :use_email_as_login
  self.admin_applications = []
  self.site_name = 'Company Name'
  self.site_id = 0
  self.short_name = 'default'
  self.javascripts = []
  self.stylesheets = []
  self.from_address = 'no-reply@companyname.com'
  self.permissions = []
  self.admin_javascripts = ['admin/core/application', 'admin/application']
  self.admin_stylesheets = ['admin/core/application', 'admin/application']
  self.production_alert_domain = nil
  self.use_email_as_login = false

  def self.append_admin_javascripts(*args)
    args = args[0] if args[0].is_a?(Array)
    TbCore.config.admin_javascripts += args
  end

  def self.append_admin_stylesheets(*args)
    args = args[0] if args[0].is_a?(Array)
    TbCore.config.admin_stylesheets += args
  end
end
