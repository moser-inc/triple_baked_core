require 'rails_helper'

describe SpudUser, type: :model do

  describe '.where_name_like' do
    it 'matches on the concatenated first and last name' do
      2.times { FactoryBot.create(:spud_user) }
      user = FactoryBot.create(:spud_user, first_name: 'Some', last_name: 'User')
      result = SpudUser.where_name_like('Some User')
      expect(result.length).to eq(1)
      expect(result.first).to eq(user)
    end
  end

  describe '.with_permission' do
    before :each do
      role = FactoryBot.create(:spud_role,
        permission_tags: ['hello']
      )
      @super_user = FactoryBot.create(:spud_user, super_admin: true)
      @admin_user = FactoryBot.create(:spud_user, super_admin: false, role: role)
      @normal_user = FactoryBot.create(:spud_user, super_admin: false)
    end

    it 'should include the admin user' do
      result = SpudUser.with_permission('hello', include_supers: false)
      expect(result.length).to eq(1)
      expect(result.first).to eq(@admin_user)
    end

    it 'should include the admin and the super user' do
      result = SpudUser.with_permission('hello')
      expect(result.length).to eq(2)
      expect(result).to_not include(@normal_user)
    end
  end

  describe '#full_name' do
    it 'should return the full name if the first and last name are not blank' do
      u = FactoryBot.build(:spud_user)
      expect(u.full_name).to  eq("#{u.first_name} #{u.last_name}")
    end

    it 'should return only the last name if the first name is blank' do
      u = FactoryBot.build(:spud_user, first_name: nil)
      expect(u.full_name).to  eq(u.last_name)
    end

    it 'should return only the first name if the last name is blank' do
      u = FactoryBot.build(:spud_user, last_name: nil)
      expect(u.full_name).to  eq(u.first_name)
    end

    it 'should return the login if the first and last name are blank' do
      u = FactoryBot.build(:spud_user, first_name: nil, last_name: nil)
      expect(u.full_name).to  eq(u.login)
    end
  end

  it 'must match password confirmation before saving a new user' do
    u = FactoryBot.build(:spud_user, password_confirmation: '')
    expect(u.save).to eq(false)
  end

  describe '#unset_requires_password_change' do
    it 'should not unset the requires_password_change flag' do
      u = FactoryBot.create(:spud_user, requires_password_change: true)
      expect{
        u.update(first_name: 'updated')
      }.to_not change(u, :requires_password_change)
    end

    it 'should unset the requires_password_change flag' do
      u = FactoryBot.create(:spud_user, requires_password_change: true)
      expect{
        u.update(password: 'new password', password_confirmation: 'new password')
        u.reload
      }.to change(u, :requires_password_change).from(true).to(false)
    end
  end

end
