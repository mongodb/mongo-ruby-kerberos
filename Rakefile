# Copyright (C) 2009-2013 MongoDB Inc.
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

require "bundler"
Bundler.setup

$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))

require "rake"
require "rake/extensiontask"
require "rspec/core/rake_task"

def jruby?
  defined?(JRUBY_VERSION)
end

if jruby?
  require "rake/javaextensiontask"
  Rake::JavaExtensionTask.new do |ext|
    ext.name = "native"
    ext.ext_dir = "src"
    ext.lib_dir = "lib/mongo/sasl"
  end
else
  require "rake/extensiontask"
  Rake::ExtensionTask.new do |ext|
    ext.name = "native"
    ext.ext_dir = "ext/mongo/sasl"
    ext.lib_dir = "lib/mongo/sasl"
  end
end

require "mongo/sasl/version"

def extension
  RUBY_PLATFORM =~ /darwin/ ? "bundle" : "so"
end

RSpec::Core::RakeTask.new(:rspec)

if jruby?
  task :build => [ :clean_all, :compile ] do
    system "gem build mongo_sasl.gemspec"
  end
else
  task :build => :clean_all do
    system "gem build mongo_sasl.gemspec"
  end
end

task :clean_all => :clean do
  begin
    Dir.chdir(Pathname(__FILE__).dirname + "lib") do
      `rm csasl.#{extension}`
      `rm csasl.o`
      `rm mongo_sasl.jar`
    end
  rescue Exception => e
    puts e.message
  end
end

task :spec => :compile do
  Rake::Task["rspec"].invoke
end

# Run bundle exec rake release with mri and jruby. Ex:
#
# rvm use 2.1.0@mongo_sasl
# bundle exec rake release
# rvm use jruby@mongo_sasl
# bundle exec rake release
task :release => :build do
  system "git tag -a v#{Mongo::SASL::VERSION} -m 'Tagging release: #{Mongo::SASL::VERSION}'"
  system "git push --tags"
  if jruby?
    system "gem push mongo_sasl-#{Mongo::SASL::VERSION}-java.gem"
    system "rm mongo_sasl-#{Mongo::SASL::VERSION}-java.gem"
  else
    system "gem push mongo_sasl-#{Mongo::SASL::VERSION}.gem"
    system "rm mongo_sasl-#{Mongo::SASL::VERSION}.gem"
  end
end

task :default => [ :clean_all, :spec ]
