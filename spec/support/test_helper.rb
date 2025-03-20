require 'authlogic/test_case'

module TbCore
  module TestHelper
    include Authlogic::TestCase

    # Use this helper in controller specs to establish a login session
    # - admin: Set to true to create a super_admin
    # - permissions: One or more permissions you want to assign to the user (a role will be auto generated)
    #
    def activate_session(admin: false, permissions: nil)
      activate_authlogic()
      if permissions
        permissions = [permissions] unless permissions.is_a?(Array)
        role = SpudRole.create(name: 'New Role', permission_tags: permissions)
      else
        role = nil
      end
      @user = FactoryBot.create(:spud_user, super_admin: admin, role: role)
      SpudUserSession.create(@user)
      return @user
    end

    # Returns the current user
    #
    def current_user
      return @user
    end
  end
end

# Insert the session helper into RSpec if it is in use
#
if defined?(RSpec)
  RSpec.configure do |config|
    config.include TbCore::TestHelper
  end
end

# Auto load the spud_user factory if FactoryBot is in use
# require 'pry'
# binding.pry
Dir[TbCore::Engine.root.join('spec/factories/spud_user_factories.rb')].each{ |f| require f } if defined?(FactoryBot)
