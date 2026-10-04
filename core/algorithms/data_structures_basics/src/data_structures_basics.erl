%% data_structures_basics — celda enlazada compartida, lista enlazada, pila y cola.
%% Especificación: 06_Data_Structures_Basics.
%%
%% Adaptación por inmutabilidad: los registros y las celdas no se mutan, se
%% copian. Enlazar produce una celda nueva, asi que insertar al final y encolar
%% reconstruyen el camino desde la cabeza hasta la ultima celda (`append_last/2`)
%% en lugar de escribir sobre la cola, porque la copia de la celda final seria
%% inalcanzable. `linked_list_insert_tail/2` y `queue_enqueue/2` son O(n); el
%% resto de operaciones conservan la complejidad de la especificacion.
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

%% Celda compartida: se construye con `init`, se observa con los accesos y se
%% enlaza con `set_next`. Erlang es inmutable, asi que enlazar devuelve una
%% celda nueva en lugar de modificar la existente.
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

%% Las operaciones que devuelven un entero usan `-1` como valor de fallo; la
%% celda y la ausencia de enlace usan `undefined`. Las que devuelven una tupla
%% devuelven la estructura resultante, o el atomo `empty` cuando no hay ninguna
%% que devolver.
-spec linked_list_get_head(linked_list()) -> integer().
linked_list_get_head(#linked_list{head = undefined}) ->
    -1;
linked_list_get_head(#linked_list{head = #cell{value = Value}}) ->
    Value.

-spec linked_list_insert_head(linked_list(), integer()) -> linked_list().
linked_list_insert_head(LinkedList, Value) ->
    case LinkedList#linked_list.head of
        undefined ->
            NewCell = #cell{value = Value, next = undefined},
            LinkedList#linked_list{head = NewCell, tail = NewCell, count = LinkedList#linked_list.count + 1};
        _ ->
            NewCell = #cell{value = Value, next = LinkedList#linked_list.head},
            LinkedList#linked_list{head = NewCell, count = LinkedList#linked_list.count + 1}
    end.

-spec linked_list_insert_tail(linked_list(), integer()) -> linked_list().
linked_list_insert_tail(#linked_list{head = undefined, count = Count} = LinkedList, Value) ->
    NewCell = #cell{value = Value, next = undefined},
    LinkedList#linked_list{head = NewCell, tail = NewCell, count = Count + 1};
linked_list_insert_tail(#linked_list{head = Head, count = Count} = LinkedList, Value) ->
    {NewHead, NewTail} = append_last(Head, Value),
    LinkedList#linked_list{head = NewHead, tail = NewTail, count = Count + 1}.

%% Elimina la primera aparicion: la cabeza pasa a ser el resto de la cadena que
%% empieza en la celda siguiente y la cola se recalcula, porque la celda
%% eliminada podia ser la ultima. La lista vacia no tiene nada que eliminar.
-spec linked_list_delete(linked_list(), integer()) ->
    {boolean(), linked_list()} | {boolean(), empty}.
linked_list_delete(#linked_list{head = undefined}, _Value) ->
    {false, empty};
linked_list_delete(#linked_list{head = Head, count = Count} = LinkedList, Value) ->
    case remove_first(Head, Value) of
        {true, NewHead} ->
            NewTail = tail_of(NewHead),
            {true, LinkedList#linked_list{head = NewHead, tail = NewTail, count = Count - 1}};
        false ->
            {false, LinkedList}
    end.

-spec linked_list_is_empty(linked_list()) -> boolean().
linked_list_is_empty(#linked_list{count = Count}) ->
    Count =:= 0.

-spec linked_list_size(linked_list()) -> non_neg_integer().
linked_list_size(#linked_list{count = Count}) ->
    Count.

%% ---------------------------------------------------------------------------
%% Stack
%% ---------------------------------------------------------------------------

-spec stack_init() -> stack().
stack_init() ->
    #stack{top = undefined, count = 0}.

-spec stack_push(stack(), integer()) -> stack().
stack_push(Stack, Value) ->
    NewCell = #cell{value = Value, next = Stack#stack.top},
    #stack{top = NewCell, count = Stack#stack.count + 1}.

-spec stack_pop(stack()) -> {integer(), stack()} | {integer(), empty}.
stack_pop(#stack{top = Top, count = Count}) ->
    case Top of
        undefined ->
            {-1, empty};
        #cell{value = Value, next = Next} ->
            NewTop = Next,
            NewCount = Count - 1,
            {Value, #stack{top = NewTop, count = NewCount}}
    end.

-spec stack_peek(stack()) -> integer().
stack_peek(#stack{top = Top}) ->
    case Top of
        undefined -> -1;
        #cell{value = Value} -> Value
    end.

-spec stack_is_empty(stack()) -> boolean().
stack_is_empty(#stack{count = Count}) ->
    Count =:= 0.

-spec stack_size(stack()) -> non_neg_integer().
stack_size(#stack{count = Count}) ->
    Count.

%% ---------------------------------------------------------------------------
%% Queue
%% ---------------------------------------------------------------------------

-spec queue_init() -> queue().
queue_init() ->
    #queue{front = undefined, rear = undefined, count = 0}.

-spec queue_enqueue(queue(), integer()) -> queue().
queue_enqueue(#queue{front = undefined, count = Count} = Queue, Value) ->
    NewCell = #cell{value = Value, next = undefined},
    Queue#queue{front = NewCell, rear = NewCell, count = Count + 1};
queue_enqueue(#queue{front = Front, count = Count} = Queue, Value) ->
    {NewFront, NewRear} = append_last(Front, Value),
    Queue#queue{front = NewFront, rear = NewRear, count = Count + 1}.

%% El frente avanza a la celda siguiente y el ultimo elemento conserva su
%% posicion como `rear`; al extraerlo la cola queda sin frente ni cola.
-spec queue_dequeue(queue()) -> {integer(), queue()} | {integer(), empty}.
queue_dequeue(#queue{front = undefined}) ->
    {-1, empty};
queue_dequeue(#queue{front = #cell{value = Value, next = Next}, rear = Rear, count = Count}) ->
    NewRear =
        case Next of
            undefined -> undefined;
            _ -> Rear
        end,
    {Value, #queue{front = Next, rear = NewRear, count = Count - 1}}.

-spec queue_peek(queue()) -> integer().
queue_peek(#queue{front = Front}) ->
    case Front of
        undefined -> -1;
        #cell{value = Value} -> Value
    end.

-spec queue_is_empty(queue()) -> boolean().
queue_is_empty(#queue{count = Count}) ->
    Count =:= 0.

-spec queue_size(queue()) -> non_neg_integer().
queue_size(#queue{count = Count}) ->
    Count.

%% ---------------------------------------------------------------------------
%% Internal helpers
%% ---------------------------------------------------------------------------

%% Copia el camino desde la primera celda hasta la ultima y enlaza una celda
%% nueva detras. Devuelve la cabeza reconstruida y la celda anadida, que pasa a
%% ser la cola de la estructura.
-spec append_last(cell(), integer()) -> {cell(), cell()}.
append_last(#cell{next = undefined} = Cell, Value) ->
    NewCell = #cell{value = Value, next = undefined},
    {Cell#cell{next = NewCell}, NewCell};
append_last(#cell{next = Next} = Cell, Value) ->
    {NewNext, NewCell} = append_last(Next, Value),
    {Cell#cell{next = NewNext}, NewCell}.

%% Copia el camino desde `Cell` hasta el final omitiendo la primera celda cuyo
%% valor coincida. `false` informa de que el valor no esta en la cadena.
-spec remove_first(cell(), integer()) -> {true, cell() | undefined} | false.
remove_first(#cell{value = Value, next = Next}, Value) ->
    {true, Next};
remove_first(#cell{next = undefined}, _Value) ->
    false;
remove_first(#cell{next = Next} = Cell, Value) ->
    case remove_first(Next, Value) of
        {true, NewNext} ->
            {true, Cell#cell{next = NewNext}};
        false ->
            false
    end.

%% Ultima celda de una cadena, o `undefined` cuando la cadena no tiene celdas.
-spec tail_of(cell() | undefined) -> cell() | undefined.
tail_of(undefined) ->
    undefined;
tail_of(#cell{next = undefined} = Cell) ->
    Cell;
tail_of(#cell{next = Next}) ->
    tail_of(Next).
