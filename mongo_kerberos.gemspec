lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongo/auth/kerberos/version'

Gem::Specification.new do |s|
  s.name              = 'mongo_kerberos'
  s.version           = Mongo::Auth::Kerberos::VERSION.dup
  s.authors           = [ 'The MongoDB Ruby Team' ]
  s.email             = 'dbx-ruby@mongodb.com'
  s.homepage          = 'https://docs.mongodb.com/ruby-driver/current/tutorials/ruby-driver-authentication/#kerberos-gssapi-mechanism'
  s.summary           = 'Kerberos authentication support for the MongoDB Ruby driver'
  s.description       = 'Adds Kerberos authentication via libsasl to the MongoDB Ruby Driver on MRI and JRuby'
  s.license           = 'Apache-2.0'

  s.metadata = {
    'bug_tracker_uri' => 'https://jira.mongodb.org/projects/RUBY',
    'changelog_uri' => 'https://github.com/mongodb/mongo-ruby-kerberos/releases',
    'documentation_uri' => 'https://www.mongodb.com/docs/ruby-driver/current/reference/authentication/#kerberos--gssapi-',
    'source_code_uri' => 'https://github.com/mongodb/mongo-ruby-kerberos'
  }

  s.files      = %w(CONTRIBUTING.md LICENSE NOTICE README.md Rakefile)
  s.files      += Dir.glob('lib/**/*')

  if RUBY_PLATFORM =~ /java/
    s.platform   = 'java'
    s.files      << 'lib/mongo/auth/kerberos/native.jar'
  else
    s.platform   = Gem::Platform::RUBY
    s.files      += Dir.glob('ext/**/*.{c,h,rb}')
    s.extensions = [ 'ext/mongo_kerberos/extconf.rb' ]
  end

  s.test_files = Dir.glob('spec/**/*')

  s.require_path              = 'lib'
  s.required_ruby_version     = '>= 1.9.3'
  s.required_rubygems_version = '>= 1.3.6'
  s.add_dependency('mongo', "~> 2.0")
end
