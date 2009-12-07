require 'rake'

task :ebuild do
  `erlc -o ebin elib/*.erl`
end

task :estart do
  exec 'erl -pa ebin -run rabbit_rpc start -noshell -sname rabbit_rpc'
end

# task :default do
#   Rake::Task[:ebuild].invoke
#   Rake::Task[:estart].invoke
# end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "snuffle"
    gem.summary = %Q{An erlang server and a Ruby Client library to expose rabbitmq internal information via BERT-RPC.}
    gem.email = "paukul@gmail.com"
    gem.homepage = "http://github.com/paukul/snuffle"
    gem.authors = ["Pascal Friederich"]
    gem.files.include(["ebin"])
    gem.files.exclude("vendor")
    gem.extensions << 'ext/extconf.rb'
    gem.add_dependency('bert', '>= 1.1.0')
    gem.add_dependency('bertrpc', '>= 1.0.0')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end