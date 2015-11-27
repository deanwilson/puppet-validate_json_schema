require 'spec_helper'

describe 'validate_json_schema' do

  # test valid json
  # #################################################

  describe 'when called with valid json' do

    valid_json = {
      "foo" => "bar",
      "elements" => 2
    }.to_json

    schema = {
      "type" => "object",
      "required" => ["elements", "foo"],
      "properties" => {
        "elements" => { "type" => "integer"},
        "foo"      => { "type" => "string" }
      }
    }.to_json

    it 'should return true' do
      should run.with_params(valid_json, schema).and_return(true)
    end

    it 'should return true with strict explicitly set to true' do
      should run.with_params(valid_json, schema, true).and_return(true)
    end

  end

  # test invalid json
  # #################################################

  describe 'when called with invalid json' do

    in_valid_json = {
      "foo" => "bar",
      "elements" => 2
    }.to_json

    failing_schema = {
      "type" => "object",
      "required" => ["elements"],
      "properties" => {
        "elements"      => { "type" => "string" }
      }
    }.to_json

    it 'should raise Puppet::ParseError' do
      expect { 
               subject.call( [ in_valid_json, failing_schema ] ) 
             }.to raise_error(Puppet::ParseError, /type Fixnum did not match/)
    end

    it 'should raise Puppet::ParseError in strict mode' do
      expect { 
               subject.call( [ in_valid_json, failing_schema, true ] ) 
             }.to raise_error(Puppet::ParseError, /contained undefined properties:/)
    end
  end

  # Invalid function call tests
  # #################################################

  it 'should throw an ArgumentError unless called with 2 or 3 arguments' do
    expect { subject.call( [ 1          ] ) }.to raise_error(ArgumentError)
    expect { subject.call( [ 1, 2, 3, 4 ] ) }.to raise_error(ArgumentError)
  end

end
