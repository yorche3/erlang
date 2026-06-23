-module(calculator_test).
-include_lib("eunit/include/eunit.hrl").

addition_test() ->
    ?assertEqual(calculator:addition(2, 3), 5).

subtraction_test() ->
    ?assertEqual(calculator:subtraction(5, 2), 3).

multiplication_test() ->
    ?assertEqual(calculator:multiplication(4, 3), 12).

division_test() ->
    ?assertEqual(calculator:division(10, 3), 3).

modulus_test() ->
    ?assertEqual(calculator:modulus(10, 3), 1).