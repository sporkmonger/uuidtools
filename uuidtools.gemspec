# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "uuidtools"
  s.version = "2.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bob Aman"]
  s.date = "2013-04-25"
  s.description = "A simple universally unique ID generation library.\n"
  s.email = "bob@sporkmonger.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["lib/compat", "lib/compat/securerandom.rb", "lib/uuidtools", "lib/uuidtools.rb", "lib/uuidtools/version.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/uuidtools", "spec/uuidtools/mac_address_spec.rb", "spec/uuidtools/utility_spec.rb", "spec/uuidtools/uuid_creation_spec.rb", "spec/uuidtools/uuid_parsing_spec.rb", "tasks/benchmark.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/metrics.rake", "tasks/rspec.rake", "tasks/rubyforge.rake", "tasks/yard.rake", "website/index.html", "CHANGELOG", "LICENSE.txt", "README.md", "Rakefile"]
  s.homepage = "http://uuidtools.rubyforge.org/"
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "UUID generator"
  s.license = "MIT"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0.7.3"])
      s.add_development_dependency(%q<rspec>, [">= 2.9.0"])
      s.add_development_dependency(%q<yard>, [">= 0.8.2"])
      s.add_development_dependency(%q<launchy>, [">= 2.0.0"])
    else
      s.add_dependency(%q<rake>, [">= 0.7.3"])
      s.add_dependency(%q<rspec>, [">= 2.9.0"])
      s.add_dependency(%q<yard>, [">= 0.8.2"])
      s.add_dependency(%q<launchy>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.7.3"])
    s.add_dependency(%q<rspec>, [">= 2.9.0"])
    s.add_dependency(%q<yard>, [">= 0.8.2"])
    s.add_dependency(%q<launchy>, [">= 2.0.0"])
  end
end
