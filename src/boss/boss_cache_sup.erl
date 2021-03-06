-module(boss_cache_sup).
-author('emmiller@gmail.com').

-behaviour(supervisor).

-export([start_link/0, start_link/1]).

-export([init/1]).

start_link() ->
    start_link([]).

start_link(StartArgs) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, StartArgs).

init(StartArgs) ->
    {ok, {{one_for_one, 10, 10}, [
                {cache_controller, {boss_cache_controller, start_link, [StartArgs]},
                    permanent,
                    2000,
                    worker,
                    [boss_cache_controller]}
                ]}}.
