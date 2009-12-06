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
    @svc.call.rabbitrpc.list_queues(@node, @vhost)
  end
  
  def list_exchanges
    @svc.call.rabbitrpc.list_exchanges(@node, @vhost)
  end
end

rabbit = RabbitRPC.new("codeslave", "rabbit")
# puts rabbit.list_queues.inspect
puts rabbit.list_exchanges.inspect