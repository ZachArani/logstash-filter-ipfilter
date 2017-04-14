Gem::Specification.new do |s|
  s.name          = 'logstash-filter-ipfilter'
  s.version       = '0.1.0'
  s.licenses      = ['Apache License (2.0)']
  s.summary       = 'Used to correlate IP ranges to external fields with a database file'
  s.description   = 'Use ip_filled to describe the type of ip (e.g. source_ip, destination_ip, etc,). Use aggregate_column to describe what column you want to aggregate the IP by and aggregate_target to chose the name of the array that the data gets sent to. See the github page for formatting details on the database along with additional examples'
  s.authors       = ['Zachary Arani']
  s.homepage      = 'https://github.com/ZachArani/logstash-filter-ipfilter'
  s.email         = 'cloud12817@gmail.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_development_dependency 'logstash-devutils'
end