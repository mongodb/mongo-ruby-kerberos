require 'spec_helper'

describe Mongo::Auth::Kerberos::Conversation do

  let(:user) do
    Mongo::Auth::User.new(user: 'test')
  end

  let(:conversation) do
    described_class.new(user, 'test.example.com')
  end

  let(:authenticator) do
    double('authenticator')
  end

  before do
    expect(Mongo::Auth::Kerberos::Authenticator).to receive(:new).
      with(user, 'test.example.com').
      and_return(authenticator)
  end

  context 'when the user has a realm', if: RUBY_PLATFORM == 'java' do

    let(:user) do
      Mongo::Auth::User.new(user: 'user1@MYREALM.ME')
    end

    it 'includes the realm in the username as it was provided' do
      expect(conversation.user.name).to eq(user.name)
    end
  end

  describe '#start' do

    let(:query) do
      conversation.start
    end

    let(:selector) do
      query.selector
    end

    before do
      expect(authenticator).to receive(:initialize_challenge).and_return('test')
    end

    it 'sets the sasl start flag' do
      expect(selector[:saslStart]).to eq(1)
    end

    it 'sets the auto authorize flag' do
      expect(selector[:autoAuthorize]).to eq(1)
    end

    it 'sets the mechanism' do
      expect(selector[:mechanism]).to eq('GSSAPI')
    end

    it 'sets the payload', unless: BSON::Environment.jruby? do
      expect(selector[:payload]).to start_with('test')
    end

    it 'sets the payload', if: BSON::Environment.jruby? do
      expect(selector[:payload].data).to start_with('test')
    end
  end

  describe '#finalize' do

    let(:reply) do
      Mongo::Protocol::Reply.new
    end

    let(:continue_token) do
      BSON::Environment.jruby? ? BSON::Binary.new('testing') : 'testing'
    end

    context 'when the conversation is a success' do

      let(:documents) do
        [{
          'conversationId' => 1,
          'done' => false,
          'payload' => continue_token,
          'ok' => 1.0
        }]
      end

      let(:query) do
        conversation.finalize(reply)
      end

      let(:selector) do
        query.selector
      end

      before do
        expect(authenticator).to receive(:evaluate_challenge).
          with('testing').and_return(continue_token)
        reply.instance_variable_set(:@documents, documents)
      end

      it 'sets the conversation id' do
        expect(selector[:conversationId]).to eq(1)
      end

      it 'sets the payload', unless: BSON::Environment.jruby? do
        expect(selector[:payload]).to eq(continue_token)
      end

      it 'sets the payload', if: BSON::Environment.jruby? do
        expect(selector[:payload].data).to eq(continue_token)
      end

      it 'sets the continue flag' do
        expect(selector[:saslContinue]).to eq(1)
      end
    end

    context 'when the auth failed' do

      let(:documents) do
        [{
          'conversationId' => 1,
          'done' => false,
          'ok' => 0.0
        }]
      end

      before do
        reply.instance_variable_set(:@documents, documents)
      end

      it 'raises an error' do
        expect {
          conversation.finalize(reply)
        }.to raise_error(Mongo::Auth::Unauthorized)
      end
    end
  end
end
