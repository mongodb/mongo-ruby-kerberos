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

### Release Integrity

Each release of this Kerberos authentication module after version 2.1.1 has been automatically built and signed using the team's GPG key.

To verify the module's gem file:

1. [Download the GPG key](https://pgp.mongodb.com/ruby-driver.asc).
2. Import the key into your GPG keyring with `gpg --import ruby-driver.asc`.
3. Download the gem file (if you don't already have it). You can download it from RubyGems with `gem fetch mongo_kerberos`, or you can download it from the [releases page](https://github.com/mongodb/mongo-ruby-kerberos/releases) on GitHub.
4. Download the corresponding detached signature file from the [same release](https://github.com/mongodb/mongo-ruby-kerberos/releases). Look at the bottom of the release that corresponds to the gem file, under the 'Assets' list, for a `.sig` file with the same version number as the gem you wish to install.
5. Verify the gem with `gpg --verify mongo_kerberos-X.Y.Z.gem.sig mongo_kerberos-X.Y.Z.gem` (replacing `X.Y.Z` with the actual version number).

You are looking for text like "Good signature from "MongoDB Ruby Driver Release Signing Key <packaging@mongodb.com>" in the output. If you see that, the signature was found to correspond to the given gem file.

(Note that other output, like "This key is not certified with a trusted signature!", is related to *web of trust* and depends on how strongly you, personally, trust the `ruby-driver.asc` key that you downloaded from us. To learn more, see https://www.gnupg.org/gph/en/manual/x334.html)

### Why not use RubyGems' gem-signing functionality?

RubyGems' own gem signing is problematic, most significantly because there is no established chain of trust related to the keys used to sign gems. RubyGems' own documentation admits that "this method of signing gems is not widely used" (see https://guides.rubygems.org/security/). Discussions about this in the RubyGems community have been off-and-on for more than a decade, and while a solution will eventually arrive, we have settled on using GPG instead for the following reasons:

1. Many of the other driver teams at MongoDB are using GPG to sign their product releases. Consistency with the other teams means that we can reuse existing tooling for our own product releases.
2. GPG is widely available and has existing tools and procedures for dealing with web of trust (though they are admittedly quite arcane and intimidating to the uninitiated, unfortunately).

Ultimately, most users do not bother to verify gems, and will not be impacted by our choice of GPG over RubyGems' native method.


## API Documentation

Please see the [Kerberos authentication section](https://www.mongodb.com/docs/ruby-driver/current/reference/authentication/#kerberos--gssapi-)
of the Ruby driver documentation for high level documentation of this library.

## Versioning

As of 2.1.0, this project adheres to the
[Semantic Versioning Specification](http://semver.org/).
