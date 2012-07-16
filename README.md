# UUIDTools

<dl>
  <dt>Homepage</dt><dd><a href="http://uuidtools.rubyforge.org/">uuidtools.rubyforge.org</a></dd>
  <dt>Author</dt><dd><a href="mailto:bob@sporkmonger.com">Bob Aman</a></dd>
  <dt>Copyright</dt><dd>Copyright © 2005-2012 Bob Aman</dd>
  <dt>License</dt><dd>Apache 2.0</dd>
</dl>

[![Build Status](https://secure.travis-ci.org/sporkmonger/uuidtools.png)](http://travis-ci.org/sporkmonger/uuidtools)
[![Dependency Status](https://gemnasium.com/sporkmonger/uuidtools.png)](https://gemnasium.com/sporkmonger/uuidtools)

# Description

UUIDTools was designed to be a simple library for generating any
of the various types of UUIDs.  It conforms to RFC 4122 whenever
possible.

# Reference

- {UUIDTools::UUID}

# Example usage

    require "uuidtools"

    UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, "www.widgets.com")
    # => #<UUID:0x287576 UUID:3d813cbb-47fb-32ba-91df-831e1593ac29>
    UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, "www.widgets.com")
    # => #<UUID:0x2a0116 UUID:21f7f8de-8051-5b89-8680-0195ef798b6a>
    UUIDTools::UUID.timestamp_create
    # => #<UUID:0x2adfdc UUID:64a5189c-25b3-11da-a97b-00c04fd430c8>
    UUIDTools::UUID.random_create
    # => #<UUID:0x19013a UUID:984265dc-4200-4f02-ae70-fe4f48964159>

# Install

    $ sudo gem install uuidtools
