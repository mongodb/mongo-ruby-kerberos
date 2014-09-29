lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongo/kerberos/version'

Gem::Specification.new do |s|
  s.name              = 'mongo_kerberos'
  s.rubyforge_project = 'mongo_kerberos'
  s.version           = Mongo::Kerberos::VERSION
  s.authors           = ['Emily Stolfo', 'Durran Jordan']
  s.email             = ['mongodb-dev@googlegroups.com']
  s.homepage          = 'http://www.mongodb.org'
  s.summary           = 'Kerberos authentication support for the MongoDB Ruby driver'
  s.description       = 'Adds kerberos authentication via libsasl to the MongoDB Ruby Driver on MRI and JRuby'
  s.license           = 'Apache License Version 2.0'

  if File.exists?('gem-private_key.pem')
    s.signing_key = 'gem-private_key.pem'
    s.cert_chain  = ['gem-public_cert.pem']
  else
    warn "[#{s.name}] Warning: No private key present, creating unsigned gem."
  end

  s.files      = %w(CONTRIBUTING.md CHANGELOG.md LICENSE NOTICE README.md Rakefile)
  s.files      += Dir.glob('lib/**/*')

  unless RUBY_PLATFORM =~ /java/
    s.platform   = Gem::Platform::RUBY
    s.files      += Dir.glob('ext/**/*.{c,h,rb}')
    s.extensions = ['ext/mongo/kerberos/extconf.rb']
  else
    s.platform   = 'java'
    s.files      << 'ext/mongo/kerberos/jsasl.jar'
  end

  s.test_files = Dir.glob('spec/**/*')

  s.require_path              = 'lib'
  s.required_ruby_version     = '>= 1.9.3'
  s.required_rubygems_version = '>= 1.3.6'
  s.has_rdoc                  = 'yard'
  s.add_dependency('mongo', "~> 2.0")
end
