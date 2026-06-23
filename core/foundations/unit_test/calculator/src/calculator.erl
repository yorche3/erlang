-module(calculator).

-export([addition/2, subtraction/2, multiplication/2, division/2, modulus/2]).

addition(A, B) -> A + B.

subtraction(A, B) -> A - B.

multiplication(A, B) ->
    multiplication(A, B, A).
multiplication(_, B, _) when B =< 0 -> 0;
multiplication(_, 1, Acc) -> Acc;
multiplication(A, B, Acc) -> multiplication(A, subtraction(B, 1), addition(Acc, A)).

division(A, B) ->
    division(A, B, 0).
division(A, B, Quotient) when A < B -> Quotient;
division(A, B, Quotient) -> division(subtraction(A, B), B, addition(Quotient, 1)).

modulus(A, B) ->
    Quotient = division(A, B),
    Product = multiplication(B, Quotient),
    subtraction(A, Product).