-module (bert).
-export ([encode/1]).

encode(Data) ->
  case Data of
    [{_A, _B}|_Others] -> check_for_dict(Data);
    [] -> {bert, nil};
    true -> {bert, true};
    false -> {bert, false};
    _Any -> _Any
  end.

check_for_dict(List) ->
  check_for_dict(List, List).

check_for_dict([{_A, _B}|Tail], List) ->
  check_for_dict(Tail, List);
check_for_dict([], List) ->
  {bert, dict, List};
check_for_dict(_Any, List) ->
  {bert, List}.