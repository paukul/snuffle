-module (queues).
-export ([list/2]).

list(Node, Vhost) ->
  utils:list_rpc_for(Node, rabbit_amqqueue, Vhost).
