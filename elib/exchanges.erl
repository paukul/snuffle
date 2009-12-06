-module (exchanges).
-export ([list/1]).

list([Node, Vhost]) ->
  utils:list_rpc_for(Node, rabbit_exchange, Vhost).
