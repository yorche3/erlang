-module(numbers_acc_test).
-include_lib("eunit/include/eunit.hrl").

sum_first_n_acc_test() ->
    ?assertEqual(numbers:sum_first_n_acc(0), 0),
    ?assertEqual(numbers:sum_first_n_acc(3), 6).

factorial_acc_test() ->
    ?assertEqual(numbers:factorial_acc(0), 1),
    ?assertEqual(numbers:factorial_acc(4), 24).

fibonacci_acc_test() ->
    ?assertEqual(numbers:fibonacci_acc(0), 0),
    ?assertEqual(numbers:fibonacci_acc(1), 1),
    ?assertEqual(numbers:fibonacci_acc(6), 8).

greatest_common_divisor_test_acc_test() ->
    ?assertEqual(numbers:greatest_common_divisor_acc(12, 8), 4),
    ?assertEqual(numbers:greatest_common_divisor_acc(7, 5), 1).

least_common_multiple_acc_test() ->
    ?assertEqual(numbers:least_common_multiple_acc(8, 6), 24),
    ?assertEqual(numbers:least_common_multiple_acc(6, 4), 12).