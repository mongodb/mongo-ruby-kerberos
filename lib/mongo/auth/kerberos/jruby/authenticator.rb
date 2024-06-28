# Copyright (C) 2014 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'java'
require 'mongo/auth/kerberos/native.jar'
require 'forwardable'

module Mongo
  module Auth
    class Kerberos

      # Wraps authenticator construction for JRuby.
      #
      # @since 2.0.0
      class Authenticator
        extend Forwardable

        # Delegate to the wrapped authenticator.
        def_delegators :@wrapped, :initialize_challenge, :evaluate_challenge

        # Crate the new authenticator.
        #
        # @example Create the authenticator.
        #   Authenticator.new(user, host)
        #
        # @param [ Mongo::Auth::User ] user The user.
        # @param [ String ] host The host.
        #
        # @since 2.0.0
        def initialize(user, host)
          @wrapped = org.mongodb.sasl.GSSAPIAuthenticator.new(
            JRuby.runtime,
            user.name,
            host,
            user.auth_mech_properties[:service_name] || 'mongodb',
            user.auth_mech_properties[:canonicalize_host_name] || false
          )
        end
      end
    end
  end
end
