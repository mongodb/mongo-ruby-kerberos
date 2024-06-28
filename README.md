# Mongo Kerberos

Provides Kerberos authentication support to the Mongo Ruby Driver.


## Compatibility

mongo_kerberos is tested against MRI (2.7+) and JRuby (9.3+).

### JRuby

In order to work with Kerberos TGTs that are in the system cache (e.g. obtained with `kinit`), the
JRuby extension sets the JVM system property "sun.security.jgss.native" to "true". Note that any
other use of the JGSS library will also be affected by this setting, meaning that any TGTs in the
system cache will be available for obtaining Kerberos credentials as well.


## Installation

libsasl is a requirement to be able to install the mongo_kerberos gem. Please see the
[Cyrus documentation](http://cyrusimap.web.cmu.edu/docs/cyrus-sasl/2.1.25/) for more
information.

With bundler, add the `mongo_kerberos` gem to your `Gemfile`.

```ruby
gem "mongo_kerberos", "~> 2.1"
```

Require the `mongo_kerberos` gem in your application.

```ruby
require "mongo_kerberos"
```


## API Documentation

Please see the [Kerberos authentication section](https://www.mongodb.com/docs/ruby-driver/current/reference/authentication/#kerberos--gssapi-)
of the Ruby driver documentation for high level documentation of this library.

## Versioning

As of 2.1.0, this project adheres to the
[Semantic Versioning Specification](http://semver.org/).
