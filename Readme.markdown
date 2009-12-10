**wip**

* install bundler if not done so already
* gem bundle
* start your rabbitmq server if not started yet
* run: rake
* run the example script (you might need to modify some params)

if you don't get a result or "badrpc nodedown" despite your rabbitmq server is running, try to start the rabbit_rpc server without the -sname rabbit_rpc argument.

This thing is far from being finished and more something to get my feet wet with erlang and bertrpc

From the example:
    hostname = `hostname`.chomp
    rabbit = RabbitRPC.new(:node => "rabbit@#{hostname}")
    puts "Listing Queues:"
    rabbit.list_queues.each { |queue| puts queue.inspect }
    puts
    puts "Listing Exchanges:"
    rabbit.list_exchanges.each { |exchange| puts exchange.inspect }
    puts
    puts "Listing Bindings"
    rabbit.list_bindings.each { |binding| puts binding.inspect }
    
    -----------------------------
    Listing Queues:
    {:messages_ready=>0, :transactions=>0, :messages_unacknowledged=>0, :memory=>1972, :messages_uncommitted=>0, :durable=>false, :messages=>0, :auto_delete=>true, :acks_uncommitted=>0, :pid=>:pid, :name=>"asdf", :arguments=>nil, :consumers=>0}

    Listing Exchanges:
    {:type=>:direct, :durable=>true, :auto_delete=>false, :name=>"amq.direct", :arguments=>nil}
    {:type=>:direct, :durable=>false, :auto_delete=>false, :name=>"snafu", :arguments=>nil}
    {:type=>:topic, :durable=>true, :auto_delete=>false, :name=>"amq.topic", :arguments=>nil}
    {:type=>:topic, :durable=>true, :auto_delete=>false, :name=>"amq.rabbitmq.log", :arguments=>nil}
    {:type=>:fanout, :durable=>true, :auto_delete=>false, :name=>"amq.fanout", :arguments=>nil}
    {:type=>:headers, :durable=>true, :auto_delete=>false, :name=>"amq.headers", :arguments=>nil}
    {:type=>:direct, :durable=>true, :auto_delete=>false, :name=>"", :arguments=>nil}
    {:type=>:headers, :durable=>true, :auto_delete=>false, :name=>"amq.match", :arguments=>nil}

    Listing Bindings
    {:routing_key=>"asdf", :queue=>"asdf", :exchange=>""}
    {:routing_key=>"blaa", :queue=>"asdf", :exchange=>"snafu"}
    {:routing_key=>"blaa.blubb", :queue=>"asdf", :exchange=>"snafu"}