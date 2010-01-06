require 'yaml'
module Configliere
  #
  # Environment -- load configuration from environment variables
  #
  module Environment
    def environment_variables *envs
      envs.each do |env|
        case env
        when Hash
          env.each do |env, param|
            adopt_environment_variable! env, param
          end
        else
          param = env.to_s.downcase.to_sym
          adopt_environment_variable! env, param
        end
      end
    end

    def adopt_environment_variable! env, param
      val = ENV[env]
      self[param] = val if val
    end
  end

  Param.class_eval do
    # include read / save operations
    include Environment
  end
end

