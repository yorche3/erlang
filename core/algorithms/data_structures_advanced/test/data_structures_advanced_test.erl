-module(data_structures_advanced_test).

-include_lib("eunit/include/eunit.hrl").

-define(M, data_structures_advanced).

%% TreeNode

tree_node_create_test() ->
    Node = ?M:tree_node_init(10),
    assert_equal("tree_node_get_value", "create a tree node", 10,
        ?M:tree_node_get_value(Node)).

tree_node_initial_links_absent_test() ->
    Node = ?M:tree_node_init(10),
    assert_equal("tree_node_get_left", "absent initial links", undefined,
        ?M:tree_node_get_left(Node)),
    assert_equal("tree_node_get_right", "absent initial links", undefined,
        ?M:tree_node_get_right(Node)).

tree_node_link_two_children_test() ->
    Parent = linked_parent(),
    assert_equal("tree_node_get_value", "link two children left", 20,
        ?M:tree_node_get_value(?M:tree_node_get_left(Parent))),
    assert_equal("tree_node_get_value", "link two children right", 30,
        ?M:tree_node_get_value(?M:tree_node_get_right(Parent))).

tree_node_traverse_each_link_test() ->
    Parent = linked_parent(),
    Left = ?M:tree_node_get_left(Parent),
    Right = ?M:tree_node_get_right(Parent),
    assert_equal("tree_node_get_left", "traverse each link, left child", 20,
        ?M:tree_node_get_value(Left)),
    assert_equal("tree_node_get_right", "traverse each link, right child", 30,
        ?M:tree_node_get_value(Right)),
    assert_equal("tree_node_get_left", "traverse each link, left child left",
        undefined, ?M:tree_node_get_left(Left)),
    assert_equal("tree_node_get_right", "traverse each link, left child right",
        undefined, ?M:tree_node_get_right(Left)),
    assert_equal("tree_node_get_left", "traverse each link, right child left",
        undefined, ?M:tree_node_get_left(Right)),
    assert_equal("tree_node_get_right", "traverse each link, right child right",
        undefined, ?M:tree_node_get_right(Right)).

tree_node_unlink_children_test() ->
    Parent = linked_parent(),
    NoLeft = ?M:tree_node_set_left(Parent, undefined),
    assert_equal("tree_node_set_left", "unlink left, left link", undefined,
        ?M:tree_node_get_left(NoLeft)),
    assert_equal("tree_node_get_value", "unlink left, parent value", 10,
        ?M:tree_node_get_value(NoLeft)),
    assert_equal("tree_node_get_value", "unlink left, right child kept", 30,
        ?M:tree_node_get_value(?M:tree_node_get_right(NoLeft))),
    NoChildren = ?M:tree_node_set_right(NoLeft, undefined),
    assert_equal("tree_node_set_right", "unlink right, left link", undefined,
        ?M:tree_node_get_left(NoChildren)),
    assert_equal("tree_node_set_right", "unlink right, right link", undefined,
        ?M:tree_node_get_right(NoChildren)),
    assert_equal("tree_node_get_value", "unlink right, parent value", 10,
        ?M:tree_node_get_value(NoChildren)).

tree_node_immutable_set_left_test() ->
    Original = ?M:tree_node_init(10),
    Updated = ?M:tree_node_set_left(Original, ?M:tree_node_init(20)),
    assert_equal("tree_node_set_left", "immutable adaptation, new node link", 20,
        ?M:tree_node_get_value(?M:tree_node_get_left(Updated))),
    assert_equal("tree_node_set_left", "immutable adaptation, original left",
        undefined, ?M:tree_node_get_left(Original)).

%% BinaryTree

binary_tree_create_empty_test() ->
    Tree = ?M:binary_tree_init(),
    assert_equal("binary_tree_is_empty", "create empty", true,
        ?M:binary_tree_is_empty(Tree)),
    assert_equal("binary_tree_size", "create empty", 0,
        ?M:binary_tree_size(Tree)),
    assert_equal("binary_tree_contains", "create empty", false,
        ?M:binary_tree_contains(Tree, 50)).

binary_tree_insert_root_test() ->
    Tree = tree_with([50]),
    assert_equal("binary_tree_size", "insert the root", 1,
        ?M:binary_tree_size(Tree)),
    assert_equal("binary_tree_is_empty", "insert the root", false,
        ?M:binary_tree_is_empty(Tree)),
    assert_equal("binary_tree_contains", "insert the root", true,
        ?M:binary_tree_contains(Tree, 50)).

binary_tree_insert_lower_and_higher_test() ->
    Tree = tree_with([50, 30, 70]),
    assert_equal("binary_tree_size", "insert lower and higher", 3,
        ?M:binary_tree_size(Tree)),
    assert_contains_all("insert lower and higher", Tree, [50, 30, 70]).

binary_tree_multilevel_branches_test() ->
    Tree = tree_with([50, 30, 70, 20, 40]),
    assert_equal("binary_tree_size", "multilevel branches", 5,
        ?M:binary_tree_size(Tree)),
    assert_contains_all("multilevel branches", Tree, [50, 30, 70, 20, 40]).

binary_tree_missing_value_nonempty_test() ->
    Tree = tree_with([50]),
    assert_equal("binary_tree_contains", "missing value in nonempty tree, 99",
        false, ?M:binary_tree_contains(Tree, 99)),
    assert_equal("binary_tree_size", "missing value in nonempty tree", 1,
        ?M:binary_tree_size(Tree)),
    assert_equal("binary_tree_contains",
        "missing value in nonempty tree, 50 kept", true,
        ?M:binary_tree_contains(Tree, 50)).

binary_tree_idempotent_duplicate_test() ->
    Tree = tree_with([50, 30, 70, 30]),
    assert_equal("binary_tree_size", "idempotent duplicate", 3,
        ?M:binary_tree_size(Tree)),
    assert_contains_all("idempotent duplicate", Tree, [50, 30, 70]).

binary_tree_ordered_insertions_test() ->
    Tree = tree_with([20, 30, 40, 50, 70]),
    assert_equal("binary_tree_size", "ordered insertions", 5,
        ?M:binary_tree_size(Tree)),
    assert_contains_all("ordered insertions", Tree, [20, 30, 40, 50, 70]),
    assert_equal("binary_tree_contains", "ordered insertions, 99 absent", false,
        ?M:binary_tree_contains(Tree, 99)).

%% Graph

graph_create_empty_test() ->
    Graph = ?M:graph_init(),
    assert_equal("graph_is_empty", "create empty", true,
        ?M:graph_is_empty(Graph)),
    assert_equal("graph_vertex_count", "create empty", 0,
        ?M:graph_vertex_count(Graph)),
    assert_equal("graph_edge_count", "create empty", 0,
        ?M:graph_edge_count(Graph)),
    assert_equal("graph_has_edge", "create empty", false,
        ?M:graph_has_edge(Graph, 10, 30)),
    assert_equal("graph_get_neighbors", "create empty", undefined,
        ?M:graph_get_neighbors(Graph, 10)).

graph_isolated_vertex_test() ->
    Graph = graph_with([10], []),
    assert_equal("graph_is_empty", "isolated vertex", false,
        ?M:graph_is_empty(Graph)),
    assert_counts("isolated vertex", Graph, 1, 0),
    assert_equal("graph_get_neighbors", "isolated vertex", [],
        ?M:graph_get_neighbors(Graph, 10)).

graph_nonconsecutive_directed_edge_test() ->
    Graph = graph_with([10, 70], [{10, 70}]),
    assert_equal("graph_has_edge", "directed edge forward", true,
        ?M:graph_has_edge(Graph, 10, 70)),
    assert_equal("graph_has_edge", "directed edge reverse", false,
        ?M:graph_has_edge(Graph, 70, 10)),
    assert_counts("nonconsecutive labels and directed edge", Graph, 2, 1).

graph_duplicate_vertex_preserves_adjacency_test() ->
    Graph0 = graph_with([10, 30], [{10, 30}]),
    Graph = ?M:graph_add_vertex(Graph0, 10),
    assert_counts("duplicate vertex preserves adjacency", Graph, 2, 1),
    assert_equal("graph_get_neighbors", "duplicate vertex preserves adjacency",
        [30], ?M:graph_get_neighbors(Graph, 10)).

graph_duplicate_edge_test() ->
    Graph = graph_with([10, 30], [{10, 30}, {10, 30}]),
    assert_counts("duplicate edge", Graph, 2, 1),
    assert_equal("graph_get_neighbors", "duplicate edge", [30],
        ?M:graph_get_neighbors(Graph, 10)).

graph_missing_endpoint_without_mutation_test() ->
    Graph = graph_with([10, 30], [{10, 30}]),
    lists:foreach(
        fun({Source, Target}) ->
            assert_equal("graph_add_edge",
                io_lib:format("missing endpoint (~p,~p)", [Source, Target]),
                undefined, ?M:graph_add_edge(Graph, Source, Target))
        end,
        [{10, 99}, {99, 10}, {98, 99}, {99, 99}]),
    assert_counts("missing endpoint without mutation", Graph, 2, 1),
    assert_equal("graph_get_neighbors", "missing endpoint, neighbours of 10",
        [30], ?M:graph_get_neighbors(Graph, 10)),
    assert_equal("graph_get_neighbors", "missing endpoint, neighbours of 30",
        [], ?M:graph_get_neighbors(Graph, 30)),
    lists:foreach(
        fun({Source, Target}) ->
            assert_equal("graph_has_edge",
                io_lib:format("missing endpoint query (~p,~p)", [Source, Target]),
                false, ?M:graph_has_edge(Graph, Source, Target))
        end,
        [{10, 99}, {99, 10}, {98, 99}, {99, 99}]),
    assert_equal("graph_get_neighbors", "missing endpoint, vertex 98", undefined,
        ?M:graph_get_neighbors(Graph, 98)),
    assert_equal("graph_get_neighbors", "missing endpoint, vertex 99", undefined,
        ?M:graph_get_neighbors(Graph, 99)).

graph_sorted_neighbours_and_counts_test() ->
    Graph = graph_with([10, 30, 50, 70],
        [{10, 70}, {10, 30}, {10, 50}, {30, 50}]),
    assert_equal("graph_get_neighbors", "sorted neighbours of 10", [30, 50, 70],
        ?M:graph_get_neighbors(Graph, 10)),
    assert_equal("graph_get_neighbors", "sorted neighbours of 30", [50],
        ?M:graph_get_neighbors(Graph, 30)),
    assert_equal("graph_get_neighbors", "sorted neighbours of 50", [],
        ?M:graph_get_neighbors(Graph, 50)),
    assert_equal("graph_get_neighbors", "sorted neighbours of 70", [],
        ?M:graph_get_neighbors(Graph, 70)),
    assert_counts("sorted neighbours and counts", Graph, 4, 4).

graph_missing_edge_query_test() ->
    Graph = graph_with([10, 30], []),
    assert_equal("graph_has_edge", "missing-edge query", false,
        ?M:graph_has_edge(Graph, 10, 30)),
    assert_counts("missing-edge query", Graph, 2, 0),
    assert_equal("graph_is_empty", "missing-edge query", false,
        ?M:graph_is_empty(Graph)).

graph_neighbours_of_missing_vertex_test() ->
    Graph = graph_with([10], []),
    Missing = ?M:graph_get_neighbors(Graph, 99),
    assert_equal("graph_get_neighbors", "neighbours of missing vertex",
        undefined, Missing),
    ?assertNotEqual(?M:graph_get_neighbors(Graph, 10), Missing,
        "graph_get_neighbors should distinguish failure from empty neighbours"),
    assert_counts("neighbours of missing vertex", Graph, 1, 0).

graph_self_loop_and_duplicate_test() ->
    Graph = graph_with([10], [{10, 10}, {10, 10}]),
    assert_equal("graph_has_edge", "self-loop and duplicate", true,
        ?M:graph_has_edge(Graph, 10, 10)),
    assert_equal("graph_get_neighbors", "self-loop and duplicate", [10],
        ?M:graph_get_neighbors(Graph, 10)),
    assert_counts("self-loop and duplicate", Graph, 1, 1).

%% Neighbours are an immutable list: only the saved-result and later-insertion
%% steps are representable; "modify a returned copy" has no equivalent.
graph_neighbour_result_isolation_test() ->
    Graph0 = graph_with([10, 30, 50], [{10, 30}]),
    Saved = ?M:graph_get_neighbors(Graph0, 10),
    Graph = add_edge_ok(Graph0, 10, 50),
    assert_equal("graph_get_neighbors", "neighbour-result isolation, saved",
        [30], Saved),
    assert_equal("graph_get_neighbors", "neighbour-result isolation, fresh",
        [30, 50], ?M:graph_get_neighbors(Graph, 10)),
    assert_counts("neighbour-result isolation", Graph, 3, 2).

%% Helpers

linked_parent() ->
    Parent = ?M:tree_node_init(10),
    WithLeft = ?M:tree_node_set_left(Parent, ?M:tree_node_init(20)),
    ?M:tree_node_set_right(WithLeft, ?M:tree_node_init(30)).

tree_with(Values) ->
    lists:foldl(
        fun(Value, Tree) -> ?M:binary_tree_insert(Tree, Value) end,
        ?M:binary_tree_init(),
        Values).

graph_with(Labels, Edges) ->
    WithVertices = lists:foldl(
        fun(Label, Graph) -> ?M:graph_add_vertex(Graph, Label) end,
        ?M:graph_init(),
        Labels),
    lists:foldl(
        fun({Source, Target}, Graph) -> add_edge_ok(Graph, Source, Target) end,
        WithVertices,
        Edges).

add_edge_ok(Graph, Source, Target) ->
    Result = ?M:graph_add_edge(Graph, Source, Target),
    ?assertNotEqual(undefined, Result,
        io_lib:format("graph_add_edge should succeed for (~p,~p)",
            [Source, Target])),
    Result.

assert_contains_all(Case, Tree, Values) ->
    lists:foreach(
        fun(Value) ->
            assert_equal("binary_tree_contains",
                io_lib:format("~s, value ~p", [Case, Value]), true,
                ?M:binary_tree_contains(Tree, Value))
        end,
        Values).

assert_counts(Case, Graph, Vertices, Edges) ->
    assert_equal("graph_vertex_count", Case, Vertices,
        ?M:graph_vertex_count(Graph)),
    assert_equal("graph_edge_count", Case, Edges,
        ?M:graph_edge_count(Graph)).

assert_equal(Subject, Case, Expected, Actual) ->
    ?assertEqual(Expected, Actual,
        io_lib:format("~s should return ~p in ~s", [Subject, Expected, Case])).
