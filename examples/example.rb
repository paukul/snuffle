require 'rubygems'
require 'snuffle'

hostname = `hostname`.chomp
rabbit = Snuffle.new(:node => "rabbit@#{hostname}")
puts "Listing Queues:"
rabbit.list_queues.each { |queue| puts queue.inspect }
puts
puts "Listing Exchanges:"
rabbit.list_exchanges.each { |exchange| puts exchange.inspect }
puts
puts "Listing Bindings"
rabbit.list_bindings.each { |binding| puts binding.inspect }