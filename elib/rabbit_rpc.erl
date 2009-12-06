-module (rabbit_rpc).
-export ([start/0, stop/0, process/1]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-behaviour(gen_server).

-record(request, {sock = undefined,
                  info = undefined,
                  action = undefined}).

-record(state, {sock = undefined}).

start() -> gen_server:start_link({global, ?MODULE}, ?MODULE, [], []).
stop() -> gen_server:call(?MODULE, stop).

process(Sock) ->
  gen_server:cast({global, ?MODULE}, {process, Sock}).

init([]) ->
  io:format("~p starting~n", [?MODULE]),
  {ok, Sock} = gen_tcp:listen(8821, [binary, {packet, 4}, {active, false}, {reuseaddr, true}]),
  spawn(fun() -> loop(Sock) end),
  {ok, #state{sock = Sock}}.

%% gen_server callbacks -export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]). start_link() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [], []). init([]) -> {ok, State}.
handle_call({call, _Module, _Function, _Arguments}, _From, State) ->
  {reply, ok, State}.
  
handle_cast({process, Sock}, State) ->
  io:format("handling cast~n"),
  Request = #request{sock = Sock},
  State2 = receive_term(Request, State),
  {noreply, State2};
handle_cast(_Msg, State) -> {noreply, State}.

receive_term(Request, State) ->
  Sock = Request#request.sock,
  case gen_tcp:recv(Sock, 0) of
    {ok, BinaryTerm} ->
      Term = binary_to_term(BinaryTerm),
      io:format("Term is: ~p~n", [Term]),
      case Term of
        _Any ->
          Request2 = Request#request{action = BinaryTerm},
          process_request(Request2, State)
      end;
    {error, closed} ->
      ok = gen_tcp:close(Sock),
      State
  end.

process_request(Request, _State) ->
  ActionTerm = binary_to_term(Request#request.action),
  Sock = Request#request.sock,
  case ActionTerm of
    {cast, _Mod, _Fun, _Args} ->
      gen_tcp:send(Sock, term_to_binary({noreply})),
      ok = gen_tcp:close(Sock);
    {call, rpc, call, Args} ->
      Result = do_rpc(Args),
      io:format("RPC result: ~p~n", [Result]),
      gen_tcp:send(Sock, term_to_binary(Result));
    {call, _Mod, _Fun, _args} ->
      gen_tcp:send(Sock, term_to_binary({reply, not_implemented}));
    _Any ->
      ok
  end.

do_rpc(Args) ->
  [Node, RPCMod, RPCFun, RPCArgs] = Args,
  try rpc:call(Node, RPCMod, RPCFun, [RPCArgs]) of
    AnyResponse -> {reply, AnyResponse}
  catch
    AnyError -> {error, AnyError}
  end.

loop(LSock) ->
  io:format("Entering loop~n"),
  {ok, Sock} = gen_tcp:accept(LSock),
  rabbit_rpc:process(Sock),
  loop(LSock).

handle_info(_Info, _State) -> {noreply, _State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.