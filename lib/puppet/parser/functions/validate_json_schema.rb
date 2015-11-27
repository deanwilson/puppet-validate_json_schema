require 'json-schema'

module Puppet::Parser::Functions

  newfunction(:validate_json_schema, :type => :rvalue, :doc =>
    "validate_json_schema usage: returns true if the given json validates against
    the provided schema. Throws a Puppet::ParseError exception if the JSON does not
    validate.

    usage: validate_json_schema(<json>, <schema>, <strict_boolan>) 
    
    $valid_json = validate_json_schema($json, $schema)
 
    # or in a conditional
    if validate_json_schema($json, $schema) == true {
      file { '/etc/app/config.json': content => $json }
    }
    
    ") do |args|

    unless (args.length >= 2 && args.length <= 3 )
      raise ArgumentError, ("validate_json_schema(): wrong number of arguments (#{args.length} must be 2 or 3)")
    end

    json_data   = args[0]
    json_schema = args[1]
    strict_validation = args[2] || false

    errors = JSON::Validator.fully_validate(json_schema, json_data, :strict => strict_validation)

    if errors.empty?
      return true
    else
      raise Puppet::ParseError, "Invalid JSON: #{errors.to_s}"
    end

  end
end
