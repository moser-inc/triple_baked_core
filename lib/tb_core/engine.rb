require 'authlogic'

module Spud
end

module TbCore
  class Engine < ::Rails::Engine
    isolate_namespace TbCore

    config.app_generators do |g|
      g.factory_bot false
    end
  end
end
