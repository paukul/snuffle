**wip**

at the moment this is more a general bertrpc to erlang:rpc wrapper but i'll abstract that later to expose only the rabbitmq calls

* install bundler if not done so already
* gem bundle
* start your rabbitmq server if not started yet
* run: erl -pa elib -run rabbit_rpc start -noshell
* run the example script

if you don't get a result or "badrpc nodedown" despite your rabbitmq server is running, try to start the rabbit_rpc server with -sname rabbitrpc.

This thing is far from being finished and more something to get my feet wet with erlang and bertrpc