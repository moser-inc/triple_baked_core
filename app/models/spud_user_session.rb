class SpudUserSession < Authlogic::Session::Base

  # Rails 4.2 fix. Possibly temporary?
  # https://github.com/binarylogic/authlogic/issues/432#issuecomment-62506755
  extend ActiveModel::Naming

  generalize_credentials_error_messages true

  # Dont update last_request_at timestamp on every page request
  last_request_at_threshold 1.minutes

  # Lock a user out after 10 failed login attempts, for 1 hour
  consecutive_failed_logins_limit 10
  failed_login_ban_for 1.hours

  # Log a user out after :logged_in_timeout has elapsed - see SpudUserModel for configuration
  logout_on_timeout true
end
