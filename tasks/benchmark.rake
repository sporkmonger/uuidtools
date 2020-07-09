task :benchmark do
  require 'benchmark'

  $LOAD_PATH.unshift File.expand_path('../..', __FILE__)
  require 'lib/uuidtools'

  def format_float(float)
    ("%.2f" % float).rjust(9, ' ')
  end

  def format_result(result, action, iterations)
    $stdout.puts "#{format_float(iterations / result.real)} | #{action}"
  end

  def benchmark(name, n = 10000)
    result = Benchmark.measure do
      n.times { yield }
    end

    format_result(result, name, n)
  end

  $stdout.puts ' x/second | Benchmark'
  $stdout.puts '---------- -----------'

  ##
  # Benchmark UUID creation
  namespace = UUIDTools::UUID_URL_NAMESPACE
  url = "http://www.ietf.org/rfc/rfc4122.txt"

  benchmark('Version 1') { UUIDTools::UUID.timestamp_create.to_s }
  benchmark('Version 3') { UUIDTools::UUID.md5_create(namespace, url).to_s }
  benchmark('Version 4') { UUIDTools::UUID.random_create.to_s }
  benchmark('Version 5') { UUIDTools::UUID.sha1_create(namespace, url).to_s }

  ## 
  # Benchmark UUID parsing
  uuid_s = UUIDTools::UUID.random_create.to_s
  benchmark('UUID::parse', 40000) { UUIDTools::UUID.parse(uuid_s) }

  uuid_raw = UUIDTools::UUID.random_create.raw
  benchmark('UUID::parse_raw', 40000) { UUIDTools::UUID.parse_raw(uuid_raw) }

  uuid_i = UUIDTools::UUID.random_create.to_i
  benchmark('UUID::parse_int', 40000) { UUIDTools::UUID.parse_int(uuid_i) }

  uuid_hex = UUIDTools::UUID.random_create.hexdigest
  benchmark('UUID::parse_hexdigest', 40000) { UUIDTools::UUID.parse_hexdigest(uuid_hex) }

  ##
  # Benchmark UUID private api
  byte_string = UUIDTools::UUID.timestamp_create.raw
  benchmark('UUID::convert_byte_string_to_int') { UUIDTools::UUID.convert_byte_string_to_int(byte_string) }

  bigint = UUIDTools::UUID.timestamp_create.to_i
  benchmark('UUID::convert_int_to_byte_string') { UUIDTools::UUID.convert_int_to_byte_string(bigint, 16) }
end
