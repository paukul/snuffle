require 'vendor/gems/environment'
require 'bert'
require 'bertrpc'

class RabbitRPC
  attr_reader :host, :nodename

  def initialize(host, nodename, vhost = '/')
    @vhost = vhost
    @node = "#{nodename}@#{host}".to_sym
    @svc = BERTRPC::Service.new('localhost', 8821)
  end

  def list_queues
    rpc(:rabbit_amqqueue, :info_all, @vhost)
  end
  
  def list_exchanges
    rpc(:rabbit_exchange, :info_all, @vhost)
  end
  
  private
  def rpc(*args)
    @svc.call.rpc.call(@node, *args)
  end
end

rabbit = RabbitRPC.new("codeslave", "rabbit")
puts rabbit.list_queues.inspect
puts rabbit.list_exchanges.inspect