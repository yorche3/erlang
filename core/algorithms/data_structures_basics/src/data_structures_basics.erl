%% data_structures_basics — celda enlazada compartida, lista enlazada, pila y cola.
%% Especificación: 06_Data_Structures_Basics.
-module(data_structures_basics).

-export([
    %% node
    node_init/1,
    node_get_value/1,
    node_get_next/1,
    node_set_next/2,
    %% linked list
    linked_list_init/0,
    linked_list_get_head/1,
    linked_list_insert_head/2,
    linked_list_insert_tail/2,
    linked_list_delete/2,
    linked_list_is_empty/1,
    linked_list_size/1,
    %% stack
    stack_init/0,
    stack_push/2,
    stack_pop/1,
    stack_peek/1,
    stack_is_empty/1,
    stack_size/1,
    %% queue
    queue_init/0,
    queue_enqueue/2,
    queue_dequeue/1,
    queue_peek/1,
    queue_is_empty/1,
    queue_size/1
]).

-export_type([cell/0, linked_list/0, stack/0, queue/0]).

%% ---------------------------------------------------------------------------
%% Types (opaque: representation hidden outside this module)
%% ---------------------------------------------------------------------------

-record(cell, {
    value :: integer(),
    next  :: cell() | undefined
}).

-record(linked_list, {
    head  :: cell() | undefined,
    tail  :: cell() | undefined,
    count :: non_neg_integer()
}).

-record(stack, {
    top   :: cell() | undefined,
    count :: non_neg_integer()
}).

-record(queue, {
    front :: cell() | undefined,
    rear  :: cell() | undefined,
    count :: non_neg_integer()
}).

-opaque cell()        :: #cell{}.
-opaque linked_list() :: #linked_list{}.
-opaque stack()       :: #stack{}.
-opaque queue()       :: #queue{}.

%% ---------------------------------------------------------------------------
%% Node — celda enlazada compartida
%% ---------------------------------------------------------------------------

%% Esqueleto del paso 4b: la celda se construye y se lee; el algoritmo es del
%% paso 5. Erlang es inmutable, asi que enlazar devuelve una celda nueva.
-spec node_init(integer()) -> cell().
node_init(Value) ->
    #cell{value = Value, next = undefined}.

-spec node_get_value(cell()) -> integer().
node_get_value(#cell{value = Value}) ->
    Value.

-spec node_get_next(cell()) -> cell() | undefined.
node_get_next(#cell{next = Next}) ->
    Next.

-spec node_set_next(cell(), cell() | undefined) -> cell().
node_set_next(#cell{} = Cell, Next) ->
    Cell#cell{next = Next}.

%% ---------------------------------------------------------------------------
%% Linked list
%% ---------------------------------------------------------------------------

-spec linked_list_init() -> linked_list().
linked_list_init() ->
    #linked_list{head = undefined, tail = undefined, count = 0}.

%% Esqueletos del paso 4b: cada operacion devuelve el indicador natural
%% (`undefined`, `false`, `0`, `{error, ...}`) o la misma estructura, sin
%% resolver ningun caso.
-spec linked_list_get_head(linked_list()) -> integer() | undefined.
linked_list_get_head(_LinkedList) ->
    undefined.

-spec linked_list_insert_head(linked_list(), integer()) -> linked_list().
linked_list_insert_head(LinkedList, _Value) ->
    LinkedList.

-spec linked_list_insert_tail(linked_list(), integer()) -> linked_list().
linked_list_insert_tail(LinkedList, _Value) ->
    LinkedList.

-spec linked_list_delete(linked_list(), integer()) ->
    {ok, linked_list()} | {error, not_found}.
linked_list_delete(_LinkedList, _Value) ->
    {error, not_found}.

-spec linked_list_is_empty(linked_list()) -> boolean().
linked_list_is_empty(_LinkedList) ->
    false.

-spec linked_list_size(linked_list()) -> non_neg_integer().
linked_list_size(_LinkedList) ->
    0.

%% ---------------------------------------------------------------------------
%% Stack
%% ---------------------------------------------------------------------------

-spec stack_init() -> stack().
stack_init() ->
    #stack{top = undefined, count = 0}.

-spec stack_push(stack(), integer()) -> stack().
stack_push(Stack, _Value) ->
    Stack.

-spec stack_pop(stack()) -> {ok, integer(), stack()} | {error, empty}.
stack_pop(_Stack) ->
    {error, empty}.

-spec stack_peek(stack()) -> integer() | undefined.
stack_peek(_Stack) ->
    undefined.

-spec stack_is_empty(stack()) -> boolean().
stack_is_empty(_Stack) ->
    false.

-spec stack_size(stack()) -> non_neg_integer().
stack_size(_Stack) ->
    0.

%% ---------------------------------------------------------------------------
%% Queue
%% ---------------------------------------------------------------------------

-spec queue_init() -> queue().
queue_init() ->
    #queue{front = undefined, rear = undefined, count = 0}.

-spec queue_enqueue(queue(), integer()) -> queue().
queue_enqueue(Queue, _Value) ->
    Queue.

-spec queue_dequeue(queue()) -> {ok, integer(), queue()} | {error, empty}.
queue_dequeue(_Queue) ->
    {error, empty}.

-spec queue_peek(queue()) -> integer() | undefined.
queue_peek(_Queue) ->
    undefined.

-spec queue_is_empty(queue()) -> boolean().
queue_is_empty(_Queue) ->
    false.

-spec queue_size(queue()) -> non_neg_integer().
queue_size(_Queue) ->
    0.
