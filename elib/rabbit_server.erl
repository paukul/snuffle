-module (rabbit_server).
-export ([status/2]).

status(Node, _) ->
  Lines = rpc:call(Node, rabbit, status, []),
  case Lines of
    {badrpc, nodedown} -> {badrpc, nodedown};
    _AnyOther -> 
      Result = bert:encode(lists:map(fun(Line) -> parse_status_line(Line) end, Lines)),
      io:format("Out with: ~p~n", [Result]),
      Result
  end.

parse_status_line(Line) ->
  Result = case Line of
    {running_applications, Applications} -> {running_applications, map_applications(Applications)};
    {nodes, Nodes} -> {nodes, Nodes};
    {running_nodes, RunningNodes} -> {running_nodes, RunningNodes}
  end,
  bert:encode(Result).

map_applications(Applications) ->
  lists:map(fun(Application) -> app_to_dict(Application) end, Applications).

app_to_dict(Application) ->
  {Process, App, Version} = Application,
  {bert, dict, [{process, Process}, {application, list_to_binary(App)}, {version, list_to_binary(Version)}]}.