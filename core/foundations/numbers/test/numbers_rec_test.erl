-module(numbers_rec_test).
-include_lib("eunit/include/eunit.hrl").

sum_first_n_rec_test() ->
    ?assertEqual(numbers:sum_first_n_rec(0), 0),
    ?assertEqual(numbers:sum_first_n_rec(3), 6).

factorial_rec_test() ->
    ?assertEqual(numbers:factorial_rec(0), 1),
    ?assertEqual(numbers:factorial_rec(4), 24).

fibonacci_rec_test() ->
    ?assertEqual(numbers:fibonacci_rec(0), 0),
    ?assertEqual(numbers:fibonacci_rec(1), 1),
    ?assertEqual(numbers:fibonacci_rec(6), 8).

greatest_common_divisor_test_rec_test() ->
    ?assertEqual(numbers:greatest_common_divisor_rec(12, 8), 4),
    ?assertEqual(numbers:greatest_common_divisor_rec(7, 5), 1).

least_common_multiple_rec_test() ->
    ?assertEqual(numbers:least_common_multiple_rec(8, 6), 24),
    ?assertEqual(numbers:least_common_multiple_rec(6, 4), 12).