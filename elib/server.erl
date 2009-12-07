-module (server).
-export ([status/1]).

status([Node, _]) ->
  Lines = rpc:call(Node, rabbit, status, []),
  Result = case Lines of
    {badrpc, nodedown} -> {badrpc, nodedown};
    _AnyOther -> lists:map(fun(Line) -> utils:parse_lines_from(Line) end, Lines)
  end,
  Result.