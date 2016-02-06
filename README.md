# puppet-validate\_json_schema #

A Puppet function to validate JSON against a [JSON schema](http://json-schema.org/)

[![Build Status](https://travis-ci.org/deanwilson/puppet-validate_json_schema.svg?branch=master)](https://travis-ci.org/deanwilson/puppet-validate_json_schema)
[![Puppet Forge](https://img.shields.io/puppetforge/v/deanwilson/validate_json_schema.svg)](https://forge.puppetlabs.com/deanwilson/validate_json_schema)


## Introduction ##

Sometimes ensuring that JSON is valid isn't enough. You could need to
assert the presence of certain values and ensure they are specific
types. In those cases validating your JSON against a schema can help
prevent you deploying well formed but invalid JSON from Puppet.

validate\_json_schema returns `true` if the supplied JSON validates
against the provided schema and throws a Puppet::ParseError and halts
the catalog run if it fails.

## Examples ##

Ensure the `json-schema` gem is installed on the puppet master:

    /opt/puppetlabs/server/bin/puppetserver gem install json-schema --no-ri --no-rdoc

Then restart your puppetmaster to pick up the new gem.

You can then use the function in your manifests:

    class json_tester {

      $json_data   = file('json_tester/valid-json.json')
      $json_schema = file('json_tester/valid-schema.json')

      if validate_json_schema($json_data, $json_schema, true) {
        file { '/tmp/valid_json':
          content => $json_data,
        }
      }
    }

If you supply invalid json you'll see an error like this on your clients 

    Error: Could not retrieve catalog from remote server:
    Error 400 on SERVER: Evaluation Error: 
    Error while evaluating a Function Call, Invalid JSON: ["The property
    '#/elements' of type String did not match the following type:
    integer in schema 5fe3442c-38ba-5365-a5ae-39a9c406c715#"] at /etc/p-
    uppetlabs/code/environments/production/modules/json_tester/manifest-
    s/init.pp:6:6 on node puppettester.example.com


### License ###

Apache 2.0 - [Dean Wilson](http://www.unixdaemon.net) 
