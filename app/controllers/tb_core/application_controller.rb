module TbCore
  class ApplicationController < ActionController::Base
    # TODO - gradually reenable
    #
    # protect_from_forgery
    #
    # include TbCore::ErrorHandling
    # include TbCore::Redirection
    # include TbCore::UserAuthentication
    # self.responder = TbCore::Responder

    def not_found
      raise NotFoundError
    end

    # ActiveSupport.run_load_hooks(:tb_core_application_controller, self)
  end
end
