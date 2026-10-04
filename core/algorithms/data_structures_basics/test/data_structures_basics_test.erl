-module(data_structures_basics_test).

-include_lib("eunit/include/eunit.hrl").

node_init_test() ->
    run_node_case(node_init).

node_get_value_test() ->
    run_node_case(node_get_value).

node_get_next_test() ->
    run_node_case(node_get_next).

node_set_next_test() ->
    run_node_case(node_set_next).

linked_list_init_test() ->
    run_linked_list_case(linked_list_init).

linked_list_get_head_test() ->
    run_linked_list_case(linked_list_get_head).

linked_list_insert_head_test() ->
    run_linked_list_case(linked_list_insert_head).

linked_list_insert_tail_test() ->
    run_linked_list_case(linked_list_insert_tail).

linked_list_delete_test() ->
    run_linked_list_case(linked_list_delete).

linked_list_is_empty_test() ->
    run_linked_list_case(linked_list_is_empty).

linked_list_size_test() ->
    run_linked_list_case(linked_list_size).

stack_init_test() ->
    run_stack_case(stack_init).

stack_push_test() ->
    run_stack_case(stack_push).

stack_pop_test() ->
    run_stack_case(stack_pop).

stack_peek_test() ->
    run_stack_case(stack_peek).

stack_is_empty_test() ->
    run_stack_case(stack_is_empty).

stack_size_test() ->
    run_stack_case(stack_size).

queue_init_test() ->
    run_queue_case(queue_init).

queue_enqueue_test() ->
    run_queue_case(queue_enqueue).

queue_dequeue_test() ->
    run_queue_case(queue_dequeue).

queue_peek_test() ->
    run_queue_case(queue_peek).

queue_is_empty_test() ->
    run_queue_case(queue_is_empty).

queue_size_test() ->
    run_queue_case(queue_size).

run_node_case(Subject) ->
    FirstNodeInput = 10,
    FirstNodeOutput = 10,
    AbsentNextOutput = undefined,
    FirstNode = data_structures_basics:node_init(FirstNodeInput),
    assert_for(Subject, node_init, "initialize and observe value/link",
        FirstNodeOutput, data_structures_basics:node_get_value(FirstNode)),
    assert_for(Subject, node_init, "initialize and observe value/link",
        AbsentNextOutput, data_structures_basics:node_get_next(FirstNode)),
    assert_for(Subject, node_get_value, "initialize and observe value/link",
        FirstNodeOutput, data_structures_basics:node_get_value(FirstNode)),
    assert_for(Subject, node_get_next, "initialize and observe value/link",
        AbsentNextOutput, data_structures_basics:node_get_next(FirstNode)),

    SecondNodeInput = 20,
    SecondNodeOutput = 20,
    SecondNode = data_structures_basics:node_init(SecondNodeInput),
    LinkedNode = data_structures_basics:node_set_next(FirstNode, SecondNode),
    assert_for(Subject, node_set_next, "link and traverse",
        SecondNodeOutput,
        data_structures_basics:node_get_value(
            data_structures_basics:node_get_next(LinkedNode))),
    assert_for(Subject, node_set_next, "link and traverse",
        AbsentNextOutput, data_structures_basics:node_get_next(SecondNode)),
    assert_for(Subject, node_get_next, "link and traverse",
        SecondNode, data_structures_basics:node_get_next(LinkedNode)).

run_linked_list_case(Subject) ->
    EmptySizeOutput = 0,
    EmptyHeadOutput = -1,
    EmptyList = data_structures_basics:linked_list_init(),
    assert_for_any(Subject, [linked_list_init, linked_list_is_empty],
        "empty state", true, data_structures_basics:linked_list_is_empty(EmptyList)),
    assert_for_any(Subject, [linked_list_init, linked_list_size],
        "empty state", EmptySizeOutput,
        data_structures_basics:linked_list_size(EmptyList)),
    assert_for_any(Subject, [linked_list_init, linked_list_get_head],
        "empty state", EmptyHeadOutput,
        data_structures_basics:linked_list_get_head(EmptyList)),

    TailFirstInput = 10,
    TailSecondInput = 20,
    HeadInput = 5,
    TailDuplicateInput = 10,
    ExpectedInsertedValues = [5, 10, 20, 10],
    ListAfterFirstTail =
        data_structures_basics:linked_list_insert_tail(EmptyList, TailFirstInput),
    ListAfterSecondTail =
        data_structures_basics:linked_list_insert_tail(
            ListAfterFirstTail, TailSecondInput),
    ListAfterHead =
        data_structures_basics:linked_list_insert_head(ListAfterSecondTail, HeadInput),
    InsertedList =
        data_structures_basics:linked_list_insert_tail(ListAfterHead, TailDuplicateInput),
    assert_for_any(Subject,
        [linked_list_insert_head, linked_list_insert_tail, linked_list_size],
        "insert at both ends", 4, data_structures_basics:linked_list_size(InsertedList)),
    assert_values_for_any(Subject,
        [linked_list_insert_head, linked_list_insert_tail],
        "insert at both ends", ExpectedInsertedValues, InsertedList),

    DeleteExistingInput = 10,
    {ok, ListAfterDelete} =
        data_structures_basics:linked_list_delete(InsertedList, DeleteExistingInput),
    assert_for(Subject, linked_list_delete, "delete first occurrence",
        3, data_structures_basics:linked_list_size(ListAfterDelete)),
    assert_values_for_any(Subject, [linked_list_delete, linked_list_get_head],
        "delete first occurrence", [5, 20, 10], ListAfterDelete),

    AbsentValueInput = 99,
    AbsentDeleteOutput = {error, not_found},
    AbsentDeleteResult =
        data_structures_basics:linked_list_delete(ListAfterDelete, AbsentValueInput),
    assert_for(Subject, linked_list_delete, "absent value",
        AbsentDeleteOutput, AbsentDeleteResult),
    {error, not_found} = AbsentDeleteResult,
    assert_values_for_any(Subject, [linked_list_delete, linked_list_size],
        "absent value", [5, 20, 10], ListAfterDelete),

    {ok, AfterHeadDelete} =
        data_structures_basics:linked_list_delete(ListAfterDelete, HeadInput),
    {ok, AfterMiddleDelete} =
        data_structures_basics:linked_list_delete(AfterHeadDelete, TailSecondInput),
    {ok, EmptiedList} =
        data_structures_basics:linked_list_delete(AfterMiddleDelete, TailDuplicateInput),
    assert_for_any(Subject, [linked_list_delete, linked_list_is_empty],
        "empty the list", true, data_structures_basics:linked_list_is_empty(EmptiedList)),
    assert_for_any(Subject, [linked_list_delete, linked_list_size],
        "empty the list", EmptySizeOutput,
        data_structures_basics:linked_list_size(EmptiedList)),
    assert_for_any(Subject, [linked_list_delete, linked_list_get_head],
        "empty the list", EmptyHeadOutput,
        data_structures_basics:linked_list_get_head(EmptiedList)).

run_stack_case(Subject) ->
    EmptySizeOutput = 0,
    EmptyValueOutput = -1,
    EmptyStack = data_structures_basics:stack_init(),
    EmptyPopOutput = {-1, EmptyStack},
    assert_for_any(Subject, [stack_init, stack_is_empty],
        "empty state and failed removal", true,
        data_structures_basics:stack_is_empty(EmptyStack)),
    assert_for_any(Subject, [stack_init, stack_size],
        "empty state and failed removal", EmptySizeOutput,
        data_structures_basics:stack_size(EmptyStack)),
    assert_for_any(Subject, [stack_init, stack_peek],
        "empty state and failed removal", EmptyValueOutput,
        data_structures_basics:stack_peek(EmptyStack)),
    assert_for_any(Subject, [stack_init, stack_pop],
        "empty state and failed removal", EmptyPopOutput,
        data_structures_basics:stack_pop(EmptyStack)),

    FirstPushInput = 10,
    SecondPushInput = 20,
    ThirdPushInput = 30,
    StackedOnce = data_structures_basics:stack_push(EmptyStack, FirstPushInput),
    StackedTwice = data_structures_basics:stack_push(StackedOnce, SecondPushInput),
    StackedThrice = data_structures_basics:stack_push(StackedTwice, ThirdPushInput),
    assert_for_any(Subject, [stack_push, stack_peek],
        "LIFO and non-mutating peek", ThirdPushInput,
        data_structures_basics:stack_peek(StackedThrice)),
    assert_for_any(Subject, [stack_push, stack_size],
        "LIFO and non-mutating peek", 3,
        data_structures_basics:stack_size(StackedThrice)),

    {ThirdPushInput, AfterFirstPop} =
        data_structures_basics:stack_pop(StackedThrice),
    ReusedPushInput = 40,
    ReusedStack = data_structures_basics:stack_push(AfterFirstPop, ReusedPushInput),
    {ReusedPushInput, AfterReusedPop} =
        data_structures_basics:stack_pop(ReusedStack),
    {SecondPushInput, AfterSecondPop} =
        data_structures_basics:stack_pop(AfterReusedPop),
    {FirstPushInput, EmptiedStack} =
        data_structures_basics:stack_pop(AfterSecondPop),
    assert_for_any(Subject, [stack_pop, stack_is_empty],
        "removal and reuse", true, data_structures_basics:stack_is_empty(EmptiedStack)),
    assert_for_any(Subject, [stack_pop, stack_size],
        "removal and reuse", EmptySizeOutput,
        data_structures_basics:stack_size(EmptiedStack)),
    assert_for_any(Subject, [stack_pop, stack_is_empty],
        "empty after removal", EmptyPopOutput,
        data_structures_basics:stack_pop(EmptiedStack)),
    assert_for(Subject, stack_is_empty, "empty after removal", true,
        data_structures_basics:stack_is_empty(EmptiedStack)).

run_queue_case(Subject) ->
    EmptySizeOutput = 0,
    EmptyValueOutput = -1,
    EmptyQueue = data_structures_basics:queue_init(),
    EmptyDequeueOutput = {-1, EmptyQueue},
    assert_for_any(Subject, [queue_init, queue_is_empty],
        "empty state and failed removal", true,
        data_structures_basics:queue_is_empty(EmptyQueue)),
    assert_for_any(Subject, [queue_init, queue_size],
        "empty state and failed removal", EmptySizeOutput,
        data_structures_basics:queue_size(EmptyQueue)),
    assert_for_any(Subject, [queue_init, queue_peek],
        "empty state and failed removal", EmptyValueOutput,
        data_structures_basics:queue_peek(EmptyQueue)),
    assert_for_any(Subject, [queue_init, queue_dequeue],
        "empty state and failed removal", EmptyDequeueOutput,
        data_structures_basics:queue_dequeue(EmptyQueue)),

    FirstEnqueueInput = 10,
    SecondEnqueueInput = 20,
    ThirdEnqueueInput = 30,
    QueuedOnce = data_structures_basics:queue_enqueue(EmptyQueue, FirstEnqueueInput),
    QueuedTwice = data_structures_basics:queue_enqueue(QueuedOnce, SecondEnqueueInput),
    QueuedThrice = data_structures_basics:queue_enqueue(QueuedTwice, ThirdEnqueueInput),
    assert_for_any(Subject, [queue_enqueue, queue_peek],
        "FIFO and non-mutating peek", FirstEnqueueInput,
        data_structures_basics:queue_peek(QueuedThrice)),
    assert_for_any(Subject, [queue_enqueue, queue_size],
        "FIFO and non-mutating peek", 3,
        data_structures_basics:queue_size(QueuedThrice)),

    {FirstEnqueueInput, AfterFirstDequeue} =
        data_structures_basics:queue_dequeue(QueuedThrice),
    ReusedEnqueueInput = 40,
    ReusedQueue =
        data_structures_basics:queue_enqueue(AfterFirstDequeue, ReusedEnqueueInput),
    {SecondEnqueueInput, AfterSecondDequeue} =
        data_structures_basics:queue_dequeue(ReusedQueue),
    {ThirdEnqueueInput, AfterThirdDequeue} =
        data_structures_basics:queue_dequeue(AfterSecondDequeue),
    {ReusedEnqueueInput, EmptiedQueue} =
        data_structures_basics:queue_dequeue(AfterThirdDequeue),
    assert_for_any(Subject, [queue_dequeue, queue_is_empty],
        "removal and reuse", true, data_structures_basics:queue_is_empty(EmptiedQueue)),
    assert_for_any(Subject, [queue_dequeue, queue_size],
        "removal and reuse", EmptySizeOutput,
        data_structures_basics:queue_size(EmptiedQueue)),
    assert_for_any(Subject, [queue_dequeue, queue_is_empty],
        "empty after removal", EmptyDequeueOutput,
        data_structures_basics:queue_dequeue(EmptiedQueue)),
    assert_for(Subject, queue_is_empty, "empty after removal", true,
        data_structures_basics:queue_is_empty(EmptiedQueue)).

assert_values_for_any(Subject, Subjects, Case, ExpectedValues, List) ->
    case lists:member(Subject, Subjects) of
        true -> assert_list_values(Subject, Case, ExpectedValues, List);
        false -> ok
    end.

assert_list_values(Subject, Case, [], List) ->
    assert_for(Subject, Subject, Case, true,
        data_structures_basics:linked_list_is_empty(List));
assert_list_values(Subject, Case, [ExpectedValue | RemainingValues], List) ->
    assert_for(Subject, Subject, Case, ExpectedValue,
        data_structures_basics:linked_list_get_head(List)),
    {ok, RemainingList} =
        data_structures_basics:linked_list_delete(List, ExpectedValue),
    assert_list_values(Subject, Case, RemainingValues, RemainingList).

assert_for(Subject, Subject, Case, Expected, Actual) ->
    ?assertEqual(Expected, Actual,
        io_lib:format("~p should return ~p in ~s", [Subject, Expected, Case]));
assert_for(_Subject, _Function, _Case, _Expected, _Actual) ->
    ok.

assert_for_any(Subject, Subjects, Case, Expected, Actual) ->
    case lists:member(Subject, Subjects) of
        true ->
            ?assertEqual(Expected, Actual,
                io_lib:format("~p should return ~p in ~s", [Subject, Expected, Case]));
        false ->
            ok
    end.
