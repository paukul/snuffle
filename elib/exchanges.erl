-module (exchanges).
-export ([list/1]).

list([Node, Vhost]) ->
  Lines = rpc:call(Node, rabbit_exchange, info_all, [Vhost]),
  Result = case Lines of
    {badrpc, nodedown} -> {badrpc, nodedown};
    _AnyOther -> lists:map(fun(Line) -> parse_lines_from(Line) end, Lines)
  end,
  Result.

parse_lines_from(List) ->
  bert:encode(lists:map(fun(Line) -> get_type_from_line(Line) end, List)).

get_type_from_line(Line) ->
  io:format("The line is ~p~n", [Line]),
  case Line of
    {name, {resource,_Vhost,exchange,Name}} ->
      {name, bert:encode(Name)};
    {Term, Value} -> {Term, bert:encode(Value)}
  end.
