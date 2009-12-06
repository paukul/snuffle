**wip**

* install bundler if not done so already
* gem bundle
* start your rabbitmq server if not started yet
* compile the erlang stuff: erlc -o ebin elib/*.erl
* run: erl -pa ebin -run rabbit_rpc start -noshell -sname rabbit_rpc
* run the example script

if you don't get a result or "badrpc nodedown" despite your rabbitmq server is running, try to start the rabbit_rpc server without the -sname rabbit_rpc argument.

This thing is far from being finished and more something to get my feet wet with erlang and bertrpc

From the example:
    rabbit = RabbitRPC.new("my-hostname", "rabbit")
    puts rabbit.list_exchanges
    # => [{:type=>:direct, :durable=>true, :auto_delete=>false, :arguments=>[], :name=>"amq.direct"}, {:type=>:topic, :durable=>true, :auto_delete=>false, :arguments=>[], :name=>"amq.topic"}, {:type=>:topic, :durable=>true, :auto_delete=>false, :arguments=>[], :name=>"amq.rabbitmq.log"}, {:type=>:fanout, :durable=>true, :auto_delete=>false, :arguments=>[], :name=>"amq.fanout"}, {:type=>:headers, :durable=>true, :auto_delete=>false, :arguments=>[], :name=>"amq.headers"}, {:type=>:direct, :durable=>true, :auto_delete=>false, :arguments=>[], :name=>""}, {:type=>:headers, :durable=>true, :auto_delete=>false, :arguments=>[], :name=>"amq.match"}]