require 'rake'

task :build do
  `erlc -o ebin elib/*.erl`
end

task :start do
  exec 'erl -pa ebin -run rabbit_rpc start -noshell -sname rabbit_rpc'
end

task :default do
  Rake::Task[:build].invoke
  Rake::Task[:start].invoke
end