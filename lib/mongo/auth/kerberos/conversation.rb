# Copyright (C) 2015 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if BSON::Environment.jruby?
  require 'mongo/auth/kerberos/jruby/authenticator'
else
  require 'mongo/auth/kerberos/mri/authenticator'
end

module Mongo
  module Auth
    class Kerberos

      # Defines behaviour around a single GSSAPI conversation between the
      # client and server.
      #
      # @since 2.0.0
      class Conversation

        # The base client continue message.
        #
        # @since 2.0.0
        CONTINUE_MESSAGE = { saslContinue: 1 }.freeze

        # The key for the done field in the responses.
        #
        # @since 2.0.0
        DONE = 'done'.freeze

        # The conversation id field.
        #
        # @since 2.0.0
        ID = 'conversationId'.freeze

        # The base client first message.
        #
        # @since 2.0.0
        START_MESSAGE = { saslStart: 1, authAuthorize: 1 }.freeze

        # @return [ Protocol::Reply ] reply The current reply in the conversation.
        attr_reader :reply

        # @return [ Authenticator ] authenticator The native SASL authenticator.
        attr_reader :authenticator

        # Finalize the conversation.
        #
        # @example Finalize the conversation.
        #   conversation.finalize(reply)
        #
        # @param [ Protocol::Reply ] reply The response from the server.
        #
        # @return [ Protocol::Query ] The next query to execute.
        #
        # @since 2.0.0
        def finalize(reply)
          validate!(reply)
          Protocol::Query.new(
            Auth::EXTERNAL,
            Database::COMMAND,
            CONTINUE_MESSAGE.merge(payload: continue_token, conversationId: id),
            limit: -1
          )
        end

        # Start the authentication conversation.
        #
        # @example Start the conversation.
        #   conversation.start
        #
        # @return [ Protocol::Query ] The command to execute.
        #
        # @since 2.0.0
        def start
          Protocol::Query.new(
            Auth::EXTERNAL,
            Database::COMMAND,
            START_MESSAGE.merge(mechanism: Kerberos::MECHANISM, payload: start_token),
            limit: -1
          )
        end

        # Get the id of the conversation.
        #
        # @example Get the id of the conversation.
        #   conversation.id
        #
        # @return [ Integer ] The conversation id.
        #
        # @since 2.0.0
        def id
          reply.documents[0][ID]
        end

        # Create the new conversation.
        #
        # @example Create the new coversation.
        #   Conversation.new(user)
        #
        # @param [ Auth::User ] user The user to converse about.
        # @param [ String ] host The host to talk to.
        #
        # @since 2.0.0
        def initialize(user, host)
          @authenticator = Authenticator.new(user, host)
        end

        private

        def start_token
          BSON::Binary.new(authenticator.initialize_challenge)
        end

        def continue_token
          BSON::Binary.new(authenticator.evaluate_challenge(reply.documents[0]['payload'].to_s))
        end

        def validate!(reply)
          raise Unauthorized.new(user) unless reply.documents[0]['ok'] == 1
          @reply = reply
        end
      end
    end
  end
end
