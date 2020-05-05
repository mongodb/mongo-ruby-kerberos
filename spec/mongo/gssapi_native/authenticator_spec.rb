require 'spec_helper'

cls = if defined?(JRUBY_VERSION)
  org.mongodb.sasl.GSSAPIAuthenticator
else
  Mongo::Auth::GSSAPIAuthenticator
end

describe cls do
  let(:authenticator) do
    if defined?(JRUBY_VERSION)
      described_class.new(
        JRuby.runtime,
        'test-user',
        'test.host',
        'service-name',
        false,
      )
    else
      described_class.new(
        'test-user',
        'test.host',
        'service-name',
        false,
      )
    end
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
        # The precise error can vary depending on system configuration
        end.should raise_error(Mongo::GssapiNative::Error, /sasl_client_start failed/)
      end
    end
  end
end
