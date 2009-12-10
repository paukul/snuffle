require 'vendor/gems/environment'
require 'bert'
require 'bertrpc'

class RabbitRPC
  attr_reader :host, :nodename

  def initialize(options = {})
    @config = {
      :cookie => nil,
      :vhost => '/',
      :node => 'rabbit@localhost',
    }.merge(options)

    @config[:cookie] ||= read_cookie.to_sym
    puts @config[:cookie]
    @config[:node]   = @config[:node].to_sym

    @svc = BERTRPC::Service.new('localhost', 8821)
  end

  def list_queues
    rabbitrpc(:list_queues)
  end
  
  def list_exchanges
    rabbitrpc(:list_exchanges)
  end
  
  def list_bindings
    rabbitrpc(:list_bindings)
  end
  
  def status
    rabbitrpc(:status)
  end
  
  private
  def rabbitrpc(command)
    @svc.call.rabbitrpc.__send__(command, @config[:node], @config[:vhost], @config[:cookie])
  end
  def read_cookie
    cookie_file = File.expand_path("~/.erlang.cookie")
    if File.exist?(cookie_file)
      File.read(cookie_file)
    else
      raise "No cookie set and cookie file not found"
    end
  end
end

hostname = `hostname`.chomp
rabbit = RabbitRPC.new(:node => "rabbit@#{hostname}")
puts "Listing Status:"
rabbit.status.inspect

# puts "Listing Queues:"
# rabbit.list_queues.each { |queue| puts queue.inspect }
# puts
# puts "Listing Exchanges:"
# rabbit.list_exchanges.each { |exchange| puts exchange.inspect }
# puts
# puts "Listing Bindings"
# rabbit.list_bindings.each { |binding| puts binding.inspect }
