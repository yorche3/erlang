-module(data_structures_advanced).

-export([
    tree_node_init/1,
    tree_node_get_value/1,
    tree_node_get_left/1,
    tree_node_get_right/1,
    tree_node_set_left/2,
    tree_node_set_right/2,
    binary_tree_init/0,
    binary_tree_insert/2,
    binary_tree_contains/2,
    binary_tree_is_empty/1,
    binary_tree_size/1,
    graph_init/0,
    graph_add_vertex/2,
    graph_add_edge/3,
    graph_has_edge/3,
    graph_get_neighbors/2,
    graph_is_empty/1,
    graph_vertex_count/1,
    graph_edge_count/1
]).

-export_type([tree_node/0, binary_tree/0, graph/0]).

-record(tree_node, {
    value :: integer(),
    left :: tree_node() | undefined,
    right :: tree_node() | undefined
}).

-record(binary_tree, {
    root :: tree_node() | undefined,
    count :: non_neg_integer()
}).

-record(graph_node, {
    value :: integer(),
    neighbors :: [integer()],
    next_vertex :: graph_node() | undefined
}).

-record(graph, {
    vertices :: graph_node() | undefined,
    vertex_count :: non_neg_integer(),
    edge_count :: non_neg_integer()
}).

-opaque tree_node() :: #tree_node{}.
-opaque binary_tree() :: #binary_tree{}.
-type graph_node() :: #graph_node{}.
-opaque graph() :: #graph{}.

-spec tree_node_init(integer()) -> tree_node().
tree_node_init(_Value) ->
    undefined.

-spec tree_node_get_value(tree_node()) -> integer().
tree_node_get_value(_Node) ->
    undefined.

-spec tree_node_get_left(tree_node()) -> tree_node() | undefined.
tree_node_get_left(_Node) ->
    undefined.

-spec tree_node_get_right(tree_node()) -> tree_node() | undefined.
tree_node_get_right(_Node) ->
    undefined.

-spec tree_node_set_left(tree_node(), tree_node() | undefined) -> tree_node().
tree_node_set_left(_Node, _Left) ->
    undefined.

-spec tree_node_set_right(tree_node(), tree_node() | undefined) -> tree_node().
tree_node_set_right(_Node, _Right) ->
    undefined.

-spec binary_tree_init() -> binary_tree().
binary_tree_init() ->
    undefined.

-spec binary_tree_insert(binary_tree(), integer()) -> binary_tree().
binary_tree_insert(_Tree, _Value) ->
    undefined.

-spec binary_tree_contains(binary_tree(), integer()) -> boolean().
binary_tree_contains(_Tree, _Value) ->
    undefined.

-spec binary_tree_is_empty(binary_tree()) -> boolean().
binary_tree_is_empty(_Tree) ->
    undefined.

-spec binary_tree_size(binary_tree()) -> non_neg_integer().
binary_tree_size(_Tree) ->
    undefined.

-spec graph_node_init(integer()) -> graph_node().
graph_node_init(_Label) ->
    undefined.

-spec graph_init() -> graph().
graph_init() ->
    undefined.

-spec graph_add_vertex(graph(), integer()) -> graph().
graph_add_vertex(_Graph, Label) ->
    graph_node_init(Label).

-spec graph_add_edge(graph(), integer(), integer()) -> graph() | undefined.
graph_add_edge(_Graph, _Source, _Target) ->
    undefined.

-spec graph_has_edge(graph(), integer(), integer()) -> boolean().
graph_has_edge(_Graph, _Source, _Target) ->
    undefined.

-spec graph_get_neighbors(graph(), integer()) -> [integer()] | undefined.
graph_get_neighbors(_Graph, _Label) ->
    undefined.

-spec graph_is_empty(graph()) -> boolean().
graph_is_empty(_Graph) ->
    undefined.

-spec graph_vertex_count(graph()) -> non_neg_integer().
graph_vertex_count(_Graph) ->
    undefined.

-spec graph_edge_count(graph()) -> non_neg_integer().
graph_edge_count(_Graph) ->
    undefined.
