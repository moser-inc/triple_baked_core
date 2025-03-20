require 'rails_helper'

describe SpudRole, type: :model do

	before :each do
		@role = FactoryBot.build(:spud_role)
		@full_access = SpudPermission.new('Test Full Access', 'admin.test.full_access')
		@partial_access = SpudPermission.new('Test Partial Access', 'admin.test.partial_access')
		TbCore.permissions += [@full_access, @partial_access]
		@role.permissions = [@partial_access]
		@role.save()
	end

	describe 'permissions' do
		it 'should return an array of SpudPermission objects' do
			expect(@role.permissions).to be_an_instance_of(Array)
			expect(@role.permissions.first).to be_an_instance_of(SpudPermission)
		end
	end

	describe 'permissions=' do
		it 'should update the SpudRolePermissions on the role' do
			original_count = @role.spud_role_permissions.length
			@role.permissions = [@full_access, @partial_access]
			@role.save
			expect(@role.spud_role_permissions.length).to be > original_count
		end
	end

	describe 'permission_tags' do
		it 'should return an array of Strings' do
			expect(@role.permission_tags).to be_an_instance_of(Array)
			expect(@role.permission_tags.first).to be_an_instance_of(String)
		end
	end

	describe 'permission_tags=' do
		it 'should update the SpudRolePermissions on the role' do
			original_count = @role.spud_role_permissions.length
			@role.permission_tags = ['admin.test.full_access', 'admin.test.partial_access']
			@role.save
			expect(@role.spud_role_permissions.length).to be > original_count
		end
	end

end
