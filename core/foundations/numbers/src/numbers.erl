-module(numbers).

-export([sum_first_n_rec/1, factorial_rec/1, fibonacci_rec/1, 
        greatest_common_divisor_rec/2, least_common_multiple_rec/2,
        sum_first_n_acc/1, factorial_acc/1, fibonacci_acc/1, 
        greatest_common_divisor_acc/2, least_common_multiple_acc/2]).

sum_first_n_rec(0) -> 0;
sum_first_n_rec(N) -> N + sum_first_n_rec(N - 1).

factorial_rec(0) -> 1;
factorial_rec(N) -> N * factorial_rec(N - 1).

fibonacci_rec(0) -> 0;
fibonacci_rec(1) -> 1;
fibonacci_rec(N) -> fibonacci_rec(N - 1) + fibonacci_rec(N - 2).

greatest_common_divisor_rec(A, 0) -> A;
greatest_common_divisor_rec(A, B) -> greatest_common_divisor_rec(B, A rem B).

least_common_multiple_rec(A, B) ->
    G = greatest_common_divisor_rec(A, B),
    A * B div G.

sum_first_n_acc(N) -> sum_first_n_help(N, 0).

sum_first_n_help(0, Acc) -> Acc;
sum_first_n_help(N, Acc) -> sum_first_n_help(N - 1, N + Acc).

factorial_acc(N) -> factorial_help(N, 1).

factorial_help(0, Acc) -> Acc;
factorial_help(1, Acc) -> Acc;
factorial_help(N, Acc) -> factorial_help(N - 1, N * Acc).

fibonacci_acc(N) -> fibonacci_help(N, 0, 1).

fibonacci_help(0, Acc1, _) -> Acc1;
fibonacci_help(N, Acc1, Acc2) -> fibonacci_help(N - 1, Acc2, Acc1 + Acc2).

greatest_common_divisor_acc(A, 0) -> A;
greatest_common_divisor_acc(A, B) -> greatest_common_divisor_acc(B, A rem B).

least_common_multiple_acc(A, B) ->
    G = greatest_common_divisor_acc(A, B),
    A * B div G.
