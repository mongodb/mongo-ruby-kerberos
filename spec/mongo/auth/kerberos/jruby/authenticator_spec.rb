require 'spec_helper'

describe Mongo::Auth::Kerberos::Authenticator do

  describe '#initialize' do

    let(:user) do
      Mongo::Auth::User.new({
        user: 'test',
        password: 'password',
        auth_mech_properties: {
          service_name: 'mongodb',
          canonicalize_host_name: true
        }
      })
    end

    let(:authenticator) do
      described_class.new(user, 'drivers@LDAPTEST.10GEN.CC')
    end

    let(:wrapped) do
      authenticator.instance_variable_get(:@wrapped)
    end

    it 'wraps the jruby extension authenticator', if: BSON::Environment.jruby? do
      expect(wrapped).to be_a(org.mongodb.sasl.GSSAPIAuthenticator)
    end
  end
end
