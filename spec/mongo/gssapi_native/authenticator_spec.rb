require 'spec_helper'

describe Mongo::Auth::GSSAPIAuthenticator do
  let(:authenticator) do
    described_class.new(
      'test-user',
      'test.host',
      'service-name',
      false,
    )
  end

  describe '#initialize' do
    it 'allows class to be instantiated' do
      authenticator.should be_a(described_class)
    end
  end

  describe '#initialize_challenge' do
    let(:challenge) { authenticator.initialize_challenge }

    context 'when an operation fails' do
      it 'raises an exception' do
        lambda do
          challenge
        end.should raise_error(Mongo::GssapiNative::Error, /sasl_client_start failed.*generic failure/)
      end
    end
  end
end
