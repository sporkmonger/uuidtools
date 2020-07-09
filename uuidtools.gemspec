# -*- encoding: utf-8 -*-
# stub: uuidtools 2.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "uuidtools".freeze
  s.version = "2.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bob Aman".freeze]
  s.date = "2020-07-09"
  s.description = "A simple universally unique ID generation library.\n".freeze
  s.email = "bob@sporkmonger.com".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["CHANGELOG".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "doc".freeze, "documentation".freeze, "lib".freeze, "lib/compat".freeze, "lib/compat/securerandom.rb".freeze, "lib/uuidtools".freeze, "lib/uuidtools.rb".freeze, "lib/uuidtools/version.rb".freeze, "pkg".freeze, "spec".freeze, "spec/spec.opts".freeze, "spec/spec_helper.rb".freeze, "spec/uuidtools".freeze, "spec/uuidtools/mac_address_spec.rb".freeze, "spec/uuidtools/utility_spec.rb".freeze, "spec/uuidtools/uuid_creation_spec.rb".freeze, "spec/uuidtools/uuid_parsing_spec.rb".freeze, "tasks".freeze, "tasks/benchmark.rake".freeze, "tasks/gem.rake".freeze, "tasks/git.rake".freeze, "tasks/metrics.rake".freeze, "tasks/rspec.rake".freeze, "tasks/yard.rake".freeze, "uuidtools.gemspec".freeze, "website".freeze, "website/index.html".freeze]
  s.homepage = "https://github.com/sporkmonger/uuidtools".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.rubygems_version = "3.0.8".freeze
  s.summary = "UUID generator".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0.7.3"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.9.0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0.8.2"])
      s.add_development_dependency(%q<launchy>.freeze, [">= 2.0.0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0.7.3"])
      s.add_dependency(%q<rspec>.freeze, [">= 2.9.0"])
      s.add_dependency(%q<yard>.freeze, [">= 0.8.2"])
      s.add_dependency(%q<launchy>.freeze, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0.7.3"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.9.0"])
    s.add_dependency(%q<yard>.freeze, [">= 0.8.2"])
    s.add_dependency(%q<launchy>.freeze, [">= 2.0.0"])
  end
end
