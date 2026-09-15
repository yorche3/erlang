-module(naive_sort).

-export([selection_sort/1, bubble_sort/1, insertion_sort/1]).

selection_sort([]) -> [];
selection_sort(List) ->
    MinIdx = pick_min(List),
    [MinIdx | selection_sort(rest(List, MinIdx))].

pick_min([H|T]) -> pick_min(T, H).

pick_min([], Min) -> Min;
pick_min([H|T], Min) when H < Min -> pick_min(T, H);
pick_min([_H|T], Min) -> pick_min(T, Min).

rest(List, Elem) ->
    case List of
        [] -> [];
        [Elem|T] -> T;
        [H|T] -> [H | rest(T, Elem)]
    end.

bubble_sort([]) -> [];
bubble_sort(List) ->
    case bubble_pass(List) of
        {Sorted, true} -> bubble_sort(Sorted);
        {Sorted, false} -> Sorted
    end.

bubble_pass([X, Y | T]) when X > Y ->
    {Rest, _Swapped} = bubble_pass([X | T]),
    {[Y | Rest], true};
bubble_pass([H | T]) ->
    {Rest, Swapped} = bubble_pass(T),
    {[H | Rest], Swapped};
bubble_pass([]) -> {[], false}.

insertion_sort([]) -> [];
insertion_sort([H|T]) -> insert(H, insertion_sort(T)).

insert(X, []) -> [X];
insert(X, [H|T]) when X =< H -> [X,H|T];
insert(X, [H|T]) -> [H | insert(X, T)].