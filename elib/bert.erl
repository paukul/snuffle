-module (bert).
-export ([encode/1]).

encode(Data) ->
  case Data of
    [{_A, _B}|_Others] -> {bert, dict, Data};
    [] -> {bert, nil};
    _Any -> _Any
  end.