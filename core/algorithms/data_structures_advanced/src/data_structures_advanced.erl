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
tree_node_init(Value) ->
    #tree_node{value = Value, left = undefined, right = undefined}.

-spec tree_node_get_value(tree_node()) -> integer().
tree_node_get_value(#tree_node{value = Value}) ->
    Value.

-spec tree_node_get_left(tree_node()) -> tree_node() | undefined.
tree_node_get_left(#tree_node{left = Left}) ->
    Left.

-spec tree_node_get_right(tree_node()) -> tree_node() | undefined.
tree_node_get_right(#tree_node{right = Right}) ->
    Right.

-spec tree_node_set_left(tree_node(), tree_node() | undefined) -> tree_node().
tree_node_set_left(Node, Left) ->
    Node#tree_node{left = Left}.

-spec tree_node_set_right(tree_node(), tree_node() | undefined) -> tree_node().
tree_node_set_right(Node, Right) ->
    Node#tree_node{right = Right}.

-spec binary_tree_init() -> binary_tree().
binary_tree_init() ->
    #binary_tree{root = undefined, count = 0}.

insert_node(Value, undefined) ->
    {#tree_node{value = Value, left = undefined, right = undefined}, true};
insert_node(Value, Node = #tree_node{value = NodeValue, left = Left}) when Value < NodeValue ->
    {NewLeft, Inserted} = insert_node(Value, Left),
    {Node#tree_node{left = NewLeft}, Inserted};
insert_node(Value, Node = #tree_node{value = NodeValue, right = Right}) when Value > NodeValue ->
    {NewRight, Inserted} = insert_node(Value, Right),
    {Node#tree_node{right = NewRight}, Inserted};
insert_node(Value, Node = #tree_node{value = NodeValue}) when Value =:= NodeValue ->
    {Node, false}.

-spec binary_tree_insert(binary_tree(), integer()) -> binary_tree().
binary_tree_insert(Tree, Value) ->
    {NewRoot, Inserted} = insert_node(Value, Tree#binary_tree.root),
    NewCount = case Inserted of
        true -> Tree#binary_tree.count + 1;
        false -> Tree#binary_tree.count
    end,
    Tree#binary_tree{root = NewRoot, count = NewCount}.

contains_node(undefined, _Value) ->
    false;
contains_node(#tree_node{value = NodeValue, left = Left}, Value) when Value < NodeValue ->
    contains_node(Left, Value);
contains_node(#tree_node{value = NodeValue, right = Right}, Value) when Value > NodeValue ->
    contains_node(Right, Value);
contains_node(#tree_node{value = NodeValue}, Value) when Value =:= NodeValue ->
    true.

-spec binary_tree_contains(binary_tree(), integer()) -> boolean().
binary_tree_contains(Tree, Value) ->
    contains_node(Tree#binary_tree.root, Value).

-spec binary_tree_is_empty(binary_tree()) -> boolean().
binary_tree_is_empty(Tree) ->
    Tree#binary_tree.count =:= 0.

-spec binary_tree_size(binary_tree()) -> non_neg_integer().
binary_tree_size(Tree) ->
    Tree#binary_tree.count.

-spec graph_node_init(integer()) -> graph_node().
graph_node_init(Label) ->
    #graph_node{value = Label, neighbors = [], next_vertex = undefined}.

-spec graph_init() -> graph().
graph_init() ->
    #graph{vertices = undefined, vertex_count = 0, edge_count = 0}.

find_vertex(undefined, _Label) ->
    undefined;
find_vertex(#graph_node{value = Value} = Node, Label) when Value =:= Label ->
    Node;
find_vertex(#graph_node{} = Node, Label) ->
    find_vertex(Node#graph_node.next_vertex, Label).

-spec graph_add_vertex(graph(), integer()) -> graph().
graph_add_vertex(Graph, Label) ->
    case find_vertex(Graph#graph.vertices, Label) of
        #graph_node{} ->
            % Vertex already exists, return the graph as is
            Graph;
        undefined ->
            NewNode = (graph_node_init(Label))#graph_node{
                next_vertex = Graph#graph.vertices
                },
            Graph#graph{
                vertices = NewNode,
                vertex_count = Graph#graph.vertex_count + 1
            }
    end.

update_vertex(undefined, _UpdatedNode) ->
    undefined;
update_vertex(#graph_node{value = Value}, #graph_node{value = Value} = UpdatedNode) ->
    UpdatedNode;
update_vertex(#graph_node{} = Node, UpdatedNode) ->
    Node#graph_node{next_vertex = update_vertex(Node#graph_node.next_vertex, UpdatedNode)}.

-spec graph_add_edge(graph(), integer(), integer()) -> graph() | undefined.
graph_add_edge(Graph, Source, Target) ->
    case {find_vertex(Graph#graph.vertices, Source),
          find_vertex(Graph#graph.vertices, Target)} of
        {#graph_node{neighbors = Neighbors} = Node, #graph_node{}} ->
            case lists:member(Target, Neighbors) of
                true ->
                    Graph; % Edge already exists
                false ->
                    UpdatedNeighbors = insert_sorted(Target, Neighbors),
                    UpdatedSourceNode = Node#graph_node{neighbors = UpdatedNeighbors},
                    % Update the graph with the new source node and edge count
                    Graph#graph{
                        vertices = update_vertex(Graph#graph.vertices, UpdatedSourceNode),
                        edge_count = Graph#graph.edge_count + 1
                    }
            end;
        _ ->
            undefined
    end.

-spec graph_has_edge(graph(), integer(), integer()) -> boolean().
graph_has_edge(Graph, Source, Target) ->
    case find_vertex(Graph#graph.vertices, Source) of
        #graph_node{neighbors = Neighbors} ->
            lists:member(Target, Neighbors);
        _ ->
            false
    end.

insert_sorted(Value, []) ->
    [Value];
insert_sorted(Value, [H | _] = List) when Value =< H ->
    [Value | List];
insert_sorted(Value, [H | T]) ->
    [H | insert_sorted(Value, T)].

-spec graph_get_neighbors(graph(), integer()) -> [integer()] | undefined.
graph_get_neighbors(Graph, Label) ->
    case find_vertex(Graph#graph.vertices, Label) of
        #graph_node{neighbors = Neighbors} ->
            Neighbors;
        _ ->
            undefined
    end.

-spec graph_is_empty(graph()) -> boolean().
graph_is_empty(Graph) ->
    Graph#graph.vertex_count =:= 0.

-spec graph_vertex_count(graph()) -> non_neg_integer().
graph_vertex_count(Graph) ->
    Graph#graph.vertex_count.

-spec graph_edge_count(graph()) -> non_neg_integer().
graph_edge_count(Graph) ->
    Graph#graph.edge_count.
