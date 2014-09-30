require 'spec_helper'

describe Mongo::Auth::Kerberos::Authenticator do

  describe '#initialize' do

    let(:user) do
      Mongo::Auth::User.new(user: 'drivers@LDAPTEST.10GEN.CC')
    end

    let(:authenticator) do
      described_class.new(user, '127.0.0.1')
    end

    let(:wrapped) do
      authenticator.instance_variable_get(:@wrapped)
    end

    it 'wraps the c extension authenticator', unless: BSON::Environment.jruby? do
      expect(wrapped).to be_a(Mongo::Auth::GSSAPIAuthenticator)
    end
  end
end
