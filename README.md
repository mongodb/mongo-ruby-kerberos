BSON [![Build Status](https://secure.travis-ci.org/mongodb/sasl-ruby.png?branch=master&.png)](http://travis-ci.org/mongodb/sasl-ruby) [![Code Climate](https://codeclimate.com/github/mongodb/sasl-ruby.png)](https://codeclimate.com/github/mongodb/sasl-ruby) [![Coverage Status](https://coveralls.io/repos/mongodb/sasl-ruby/badge.png?branch=master)](https://coveralls.io/r/mongodb/sasl-ruby?branch=master)
====

Provides SASL authentication support to the Mongo Ruby Driver.

Compatibility
-------------

mongo_sasl is tested against MRI (1.9.2+), JRuby (1.7.0+) and Rubinius (2.0.0+).

Installation
------------

libsasl is a requirement to be able to install the mongo_sasl gem. Please see the
[Cyrus documentation](http://cyrusimap.web.cmu.edu/docs/cyrus-sasl/2.1.25/) for more
information.

With bundler, add the `mongo_sasl` gem to your `Gemfile`.

```ruby
gem "mongo_sasl", "~> 1.0"
```

Require the `mongo_sasl` gem in your application.

```ruby
require "mongo_sasl"
```

Usage
-----


API Documentation
-----------------

The [API Documentation](http://rdoc.info/github/mongodb/sasl-ruby/master/frames) is
located at rdoc.info.

Versioning
----------

As of 1.0.0, this project adheres to the [Semantic Versioning Specification](http://semver.org/).
