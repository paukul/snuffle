require 'vendor/gems/environment'
require 'bert'
require 'bertrpc'

class RabbitRPC
  attr_reader :host, :nodename

  def initialize(host, nodename, cookie = nil, vhost = '/')
    @cookie = cookie || read_cookie
    puts @cookie
    @vhost = vhost
    @node = "#{nodename}@#{host}".to_sym
    @svc = BERTRPC::Service.new(host, 8821)
  end

  def list_queues
    @svc.call.rabbitrpc.list_queues(@node, @vhost)
  end
  
  def list_exchanges
    @svc.call.rabbitrpc.list_exchanges(@node, @vhost)
  end
  
  def list_bindings
    @svc.call.rabbitrpc.list_bindings(@node, @vhost)
  end
  
  private
  def read_cookie
    cookie_file = File.expand_path("~/.erlang.cookie")
    if File.exist?(cookie_file)
      File.read(cookie_file)
    else
      raise "No cookie set and cookie file not found"
    end
  end
end

rabbit = RabbitRPC.new(`hostname`.chomp, "rabbit")
# puts "Listing Queues:"
# rabbit.list_queues.each { |queue| puts queue.inspect }
# puts
# puts "Listing Exchanges:"
# rabbit.list_exchanges.each { |exchange| puts exchange.inspect }
# puts
# puts "Listing Bindings"
# rabbit.list_bindings.each { |binding| puts binding.inspect }