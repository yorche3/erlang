-module(hello_world).
-export([main/0]).

main() ->
  io:fwrite("Hello, World! from Erlang!\n").