-module(hello_user).
-export([main/0]).

main() ->
   Name = io:get_line("Enter your name: "),
   io:fwrite("Hello, ~s", [Name]).