-module (bindings).
-export ([list/1]).

list([Node, Vhost]) ->
  Lines = rpc:call(Node, rabbit_exchange, list_bindings, [Vhost]),
  lists:map(fun(Line) -> create_binding_dict(Line) end, Lines).

create_binding_dict(Line) ->
  {ExchangeInfo, QueueInfo, RoutingKey, _} = Line,
  Dict = lists:map(fun(Item) -> extract_key_value_pair(Item) end, [ExchangeInfo, QueueInfo, RoutingKey]),
  {bert, dict, Dict}.

extract_key_value_pair(Item) ->
  case Item of
    {resource, _, exchange, Exchange} -> {exchange, Exchange};
    {resource, _, queue, Queue} -> {queue, Queue};
    RoutingKey -> {routing_key, RoutingKey}
  end. 