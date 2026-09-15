-module(naive_sort_test).

-include_lib("eunit/include/eunit.hrl").

%% Casos de prueba de la especificación 05_Naive_Sort.md
-define(STANDARD_INPUT, [5, 2, 9, 1, 5, 6]).
-define(STANDARD_OUTPUT, [1, 2, 5, 5, 6, 9]).

-define(SORTED_INPUT, [1, 2, 3, 4, 5]).
-define(SORTED_OUTPUT, [1, 2, 3, 4, 5]).

-define(REVERSE_INPUT, [5, 4, 3, 2, 1]).
-define(REVERSE_OUTPUT, [1, 2, 3, 4, 5]).

-define(IDENTICAL_INPUT, [7, 7, 7, 7]).
-define(IDENTICAL_OUTPUT, [7, 7, 7, 7]).

-define(NEGATIVE_INPUT, [3, -1, 4, -5, 0]).
-define(NEGATIVE_OUTPUT, [-5, -1, 0, 3, 4]).

-define(SINGLE_INPUT, [42]).
-define(SINGLE_OUTPUT, [42]).

-define(EMPTY_INPUT, []).
-define(EMPTY_OUTPUT, []).

%% Caso nulo: Erlang no tiene `null`/`nil` y `list()` no puede representar una
%% entrada inválida, por lo que el caso nulo de la especificación se omite: no
%% existe tal entrada.
cases() ->
    [{"an unsorted array", ?STANDARD_INPUT, ?STANDARD_OUTPUT},
     {"an already sorted array", ?SORTED_INPUT, ?SORTED_OUTPUT},
     {"a reverse ordered array", ?REVERSE_INPUT, ?REVERSE_OUTPUT},
     {"an array of identical elements", ?IDENTICAL_INPUT, ?IDENTICAL_OUTPUT},
     {"an array with negative numbers", ?NEGATIVE_INPUT, ?NEGATIVE_OUTPUT},
     {"a single element array", ?SINGLE_INPUT, ?SINGLE_OUTPUT},
     {"an empty array", ?EMPTY_INPUT, ?EMPTY_OUTPUT}].

%% Las listas de Erlang son inmutables: no hace falta copiar los fixtures porque
%% ninguna función puede mutarlos entre casos.
assert_sorts_all_cases(SortFun, Algorithm) ->
    [{Algorithm ++ " should sort " ++ Description,
      fun() -> ?assertEqual(Expected, SortFun(Input)) end}
     || {Description, Input, Expected} <- cases()].

selection_sort_test_() ->
    assert_sorts_all_cases(fun naive_sort:selection_sort/1, "selection_sort").

bubble_sort_test_() ->
    assert_sorts_all_cases(fun naive_sort:bubble_sort/1, "bubble_sort").

insertion_sort_test_() ->
    assert_sorts_all_cases(fun naive_sort:insertion_sort/1, "insertion_sort").
