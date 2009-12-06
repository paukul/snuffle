-module (utils).
-export ([parse_lines_from/1, list_rpc_for/3]).

% API
parse_lines_from(List) ->
  bert:encode(lists:map(fun(Line) -> get_type_from_line(Line) end, List)).

list_rpc_for(Node, Resource, Vhost) ->
  Lines = rpc:call(Node, Resource, info_all, [Vhost]),
  Result = case Lines of
    {badrpc, nodedown} -> {badrpc, nodedown};
    _AnyOther -> lists:map(fun(Line) -> utils:parse_lines_from(Line) end, Lines)
  end,
  Result.

% Internal
get_type_from_line(Line) ->
  % io:format("The line is ~p~n", [Line]),
  case Line of
    {name, {resource,_Vhost,_Resourcetype,Name}} ->
      {name, bert:encode(Name)};
    {pid, _Pid} -> {pid, pid};
    {Term, Value} -> {Term, bert:encode(Value)}
  end.
