# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{snuffle}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pascal Friederich"]
  s.date = %q{2009-12-07}
  s.default_executable = %q{snuffle}
  s.email = %q{paukul@gmail.com}
  s.executables = ["snuffle"]
  s.extensions = ["ext/extconf.rb"]
  s.files = [
    ".gitignore",
     "Gemfile",
     "Rakefile",
     "Readme.markdown",
     "VERSION.yml",
     "ebin/.gitignore",
     "elib/bert.erl",
     "elib/bindings.erl",
     "elib/erl_crash.dump",
     "elib/exchanges.erl",
     "elib/queues.erl",
     "elib/rabbit_rpc.erl",
     "elib/utils.erl",
     "examples/example.rb",
     "ext/Makefile",
     "ext/extconf.rb",
     "lib/snuffle.rb",
     "pkg/snuffle-0.1.0.gem",
     "snuffle.gemspec"
  ]
  s.homepage = %q{http://github.com/paukul/snuffle}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An erlang server and a Ruby Client library to expose rabbitmq internal information via BERT-RPC.}
  s.test_files = [
    "examples/example.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bert>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<bertrpc>, [">= 1.0.0"])
    else
      s.add_dependency(%q<bert>, [">= 1.1.0"])
      s.add_dependency(%q<bertrpc>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<bert>, [">= 1.1.0"])
    s.add_dependency(%q<bertrpc>, [">= 1.0.0"])
  end
end
