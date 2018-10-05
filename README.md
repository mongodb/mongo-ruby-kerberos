Mongo Kerberos [![Build Status](https://secure.travis-ci.org/mongodb/mongo-ruby-kerberos.png?branch=master&.png)](http://travis-ci.org/mongodb/mongo-ruby-kerberos) [![Code Climate](https://codeclimate.com/github/mongodb/mongo-ruby-kerberos.png)](https://codeclimate.com/github/mongodb/mongo-ruby-kerberos) [![Coverage Status](https://coveralls.io/repos/mongodb/mongo-ruby-kerberos/badge.png?branch=master)](https://coveralls.io/r/mongodb/mongo-ruby-kerberos?branch=master)
====

Provides Kerberos authentication support to the Mongo Ruby Driver.

Compatibility
-------------

mongo_kerberos is tested against MRI (1.9.2+) and JRuby (1.7.0+)

Installation
------------

libsasl is a requirement to be able to install the mongo_kerberos gem. Please see the
[Cyrus documentation](http://cyrusimap.web.cmu.edu/docs/cyrus-sasl/2.1.25/) for more
information.

With bundler, add the `mongo_kerberos` gem to your `Gemfile`.

```ruby
gem "mongo_kerberos", "~> 2.0"
```

Require the `mongo_kerberos` gem in your application.

```ruby
require "mongo_kerberos"
```

Note about JRuby
-----

In order to work with Kerberos TGTs that are in the system cache (e.g. obtained with `kinit`), the
JRuby extension sets the JVM system property "sun.security.jgss.native" to "true". Note that any
other use of the JGSS library will also be affected by this setting, meaning that any TGTs in the
system cache will be available for obtaining Kerberos credentials as well.


API Documentation
-----------------

The [API Documentation](http://rdoc.info/github/mongodb/mongo-ruby-kerberos/master/frames) is
located at rdoc.info.

Versioning
----------

As of 2.0.0, this project adheres to the [Semantic Versioning Specification](http://semver.org/).
