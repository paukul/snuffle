-module (exchanges).
-export ([list/1]).

list([Node, Vhost]) ->
  Lines = rpc:call(Node, rabbit_exchange, info_all, [Vhost]),
  Result = lists:map(fun(Line) -> parse_lines_from(Line) end, Lines),
  Result.

parse_lines_from(List) ->
  {bert, dict, lists:map(fun(Line) -> get_type_from_line(Line) end, List)}.

get_type_from_line(Line) ->
  io:format("The line is ~p~n", [Line]),
  case Line of
    {name, {resource,_Vhost,exchange,Name}} ->
      {name, Name};
    {durable, Bool} ->
      {durable, boolean_bert(Bool)};
    {auto_delete, Bool} ->
      {auto_delete, boolean_bert(Bool)};
    Any -> Any
  end.

boolean_bert(true) ->
  {bert, true};
boolean_bert(false) ->
  {bert, false}.