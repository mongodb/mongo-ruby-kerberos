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

require 'mongo/sasl/native'

module Mongo
  module Auth
    class Kerberos

      # Wraps authenticator construction for MRI.
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
          @wrapped = GSSAPIAuthenticator.new(
            user.name,
            host,
            user.gssapi_service_name,
            user.canonicalize_host_name
          )
        end
      end
    end
  end
end
