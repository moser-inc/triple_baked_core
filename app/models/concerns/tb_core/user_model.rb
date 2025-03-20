module TbCore
  module UserModel
    extend ActiveSupport::Concern

    # rubocop:disable Metrics/BlockLength
    included do
      self.table_name = 'spud_users'

      acts_as_authentic do |c|
        c.crypto_provider = Authlogic::CryptoProviders::SCrypt
        c.logged_in_timeout = 24.hours
        c.login_field = :email if TbCore.config.use_email_as_login
        c.require_password_confirmation = true
      end

      attr_accessor :password_confirmation

      belongs_to :role,
        class_name: 'SpudRole', foreign_key: :spud_role_id, optional: true
      has_many :spud_user_settings,
        dependent: :destroy, foreign_key: :spud_user_id

      validates :first_name, :last_name, presence: true
      before_validation :set_login_to_email, if: -> { TbCore.config.use_email_as_login }

      before_update :unset_requires_password_change

      scope :admins, lambda {
        where('super_admin = 1 OR role_id IS NOT NULL')
      }

      scope :ordered, -> { order('last_name asc, first_name asc, email asc') }

      # These used to be built in to Authlogic
      # See: https://github.com/binarylogic/authlogic/blob/5986e1bd056ccecc519d9f49cc83a0ba757668b4/doc/use_normal_rails_validation.md
      validates :email,
        format: {
          with: URI::MailTo::EMAIL_REGEXP,
          message: proc {
            ::Authlogic::I18n.t(
              'error_messages.email_invalid',
              default: 'should look like an email address.'
            )
          }
        },
        length: { maximum: 100 },
        uniqueness: {
          case_sensitive: false,
          if: :will_save_change_to_email?
        }
      validates :password,
        confirmation: { if: :require_password? },
        length: {
          minimum: 8,
          if: :require_password?
        }
      validates :password_confirmation,
        length: {
          minimum: 8,
          if: :require_password?
        }
    end
    # rubocop:enable Metrics/BlockLength

    module ClassMethods

      # Returns an ActiveRecord::Relation performing a LIKE query against name columns
      def where_name_like(string)
        full_name = Arel::Nodes::NamedFunction.new(
          'concat',
          [arel_table[:first_name], Arel::Nodes.build_quoted(' '), arel_table[:last_name]]
        )
        search = '%' + string + '%'
        where(full_name.matches(search))
      end

      # Return an array of users who have the requested permission
      #
      # * tag - Desired permission tag string (required)
      # * include_supers - Whether to include super user (default: true)
      def with_permission(tag, include_supers: true)
        role_ids = SpudRolePermission.where(spud_permission_tag: tag).pluck(:spud_role_id).uniq()
        if include_supers
          where(super_admin: true).or(where(spud_role_id: role_ids))
        else
          where(spud_role_id: role_ids)
        end
      end

      def as_csv(column_names)
        CSV.generate do |csv|
          csv << column_names
          all.find_each do |item|
            csv << item.attributes.values_at(*column_names)
          end
        end
      end

    end

    def full_name
      return login if first_name.blank? && last_name.blank?

      [first_name, last_name].reject(&:blank?).join(' ')
    end

    def full_name_with_email
      "#{full_name} (#{email})"
    end

    # Returns true if user can view at least one dashboard app
    def admin_rights?
      return true if super_admin

      TbCore.admin_applications.find { |app| can_view_app?(app) }.present?
    end

    # Returns true if the user can view a spud app based on it's key
    def can_view_app?(admin_application)
      return true if super_admin?

      key = admin_application[:key]
      permissions.find { |p| p.apps.include?(key) }.present?
    end

    # Check if a user has a given list of permissions
    #
    # * if one tag is supplied, return true if the tag matches
    # * if multiple tags are supplied, return true if ALL tags match
    def permission?(*tags)
      return true if super_admin?

      my_tags = permissions.collect(&:tag)
      tags.find { |tag| !my_tags.include?(tag) }.blank?
    end

    # Check if a user has at least one out of a given list of permissions
    #
    # * if one tag is supplied, return true if the tag matches
    # * if multiple tags are supplied, return true if ANY tag matches
    def any_permission?(*tags)
      return true if super_admin?

      permissions.find { |p| tags.include?(p.tag) }.present?
    end

    # Return a list of SpudPermission objects for the user's SpudRole
    def permissions
      return [] if role.blank?

      role.permissions
    end

    private

    def set_login_to_email
      self.login = email if email.present?
      true
    end

    def unset_requires_password_change
      self.requires_password_change = false if password_changed? && !requires_password_change_changed?(to: true)
      true
    end
  end
end
