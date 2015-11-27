class json_tester {

  $json_data   = file('json_tester/valid-json.json')
  $json_schema = file('json_tester/valid-schema.json')

  if validate_json_schema($json_data, $json_schema, true) {
    file { '/tmp/valid_json':
      content => $json_data,
    }
  }

}

