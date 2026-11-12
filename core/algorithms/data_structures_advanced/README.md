# Data Structures Advanced — Erlang

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **Erlang**, estructurada como biblioteca OTP estándar compilada con **rebar3** y verificada con pruebas unitarias en **EUnit**.

Implementation of the [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) specification in **Erlang**, structured as a standard OTP library built with **rebar3** and verified with **EUnit** unit tests.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / File | Propósito / Purpose |
|---|---|
| [`src/data_structures_advanced.erl`](src/data_structures_advanced.erl) | Implementación de `tree_node`, `binary_tree` y `graph` con registros dedicados / Implementation of `tree_node`, `binary_tree`, and `graph` with dedicated records |
| [`src/data_structures_advanced.app.src`](src/data_structures_advanced.app.src) | Metadatos de la aplicación OTP / OTP application metadata |
| [`test/data_structures_advanced_test.erl`](test/data_structures_advanced_test.erl) | Suite de pruebas unitarias con EUnit (24 pruebas) / EUnit unit test suite (24 tests) |
| [`rebar.config`](rebar.config) | Configuración de compilación para rebar3 / Compilation configuration for rebar3 |
| [`.gitignore`](.gitignore) | Exclusiones de artefactos generados por rebar3 y Erlang (`_build/`, etc.) / Git exclusions for rebar3 and Erlang build artifacts (`_build/`, etc.) |
| [`LICENSE.md`](LICENSE.md) | Licencia del proyecto / Project license |

**Estructura de directorios / Directory structure:**

```text
data_structures_advanced/
├── rebar.config                        # Configuración de compilación / Build configuration
├── LICENSE.md                          # Licencia / License
├── .gitignore                          # Exclusiones de Git / Git exclusions
├── src/
│   ├── data_structures_advanced.erl    # Módulo principal / Main module
│   └── data_structures_advanced.app.src # Metadatos OTP / OTP metadata
└── test/
    └── data_structures_advanced_test.erl # Suite de pruebas EUnit / EUnit test suite
```

**Desviación respecto a la ubicación esperada / Deviation from expected location:**

**ES:** La especificación propone `src/data_structures_advanced.ext` y una carpeta `test/` con un ejecutable `run_tests.ext`. En Erlang/OTP y rebar3, la convención canónica ubica el código fuente de la biblioteca en `src/` y la suite de pruebas en `test/` con sufijo `_test.erl`, ejecutándose directamente con `rebar3 eunit`.

**EN:** The specification suggests `src/data_structures_advanced.ext` and a `test/` folder with a `run_tests.ext` runner. In Erlang/OTP and rebar3, canonical layout places library sources under `src/` and the test suite under `test/` with `_test.erl` suffix, executed directly via `rebar3 eunit`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El módulo se creó a partir de la plantilla de biblioteca estándar de rebar3 (`rebar3 new lib data_structures_advanced`). Al ser Erlang un lenguaje funcional inmutable, los registros no se mutan en memoria; cada operación devuelve una nueva instancia con los enlaces o registros reconstruidos persistentemente. El valor de `Node` se incorpora por **valor embebido** en `#tree_node{value, left, right}` y `#graph_node{value, neighbors, next_vertex}`. El grafo implementa un registro enlazado canónico de vértices mediante `#graph_node.next_vertex` con búsqueda manual `find_vertex/2` ($O(V)$) y almacenamiento de vecinos en lista enlazada nativa con inserción ordenada manual `insert_sorted/2` ($O(d(u))$), sin recurrir a diccionarios, mapas ni módulos de ordenación de biblioteca.

**EN:** The module was scaffolded using the standard rebar3 library template (`rebar3 new lib data_structures_advanced`). As Erlang is an immutable functional language, records are never mutated in place; each operation returns a new instance with persistent reconstruction of links or records. The `Node` base value is incorporated via an **embedded value** in `#tree_node{value, left, right}` and `#graph_node{value, neighbors, next_vertex}`. The graph implements a canonical linked vertex registry using `#graph_node.next_vertex` with manual `find_vertex/2` traversal ($O(V)$) and neighbour storage in a native linked list with manual `insert_sorted/2` ($O(d(u))$), without relying on dictionaries, maps, or library sorting modules.

---

## 📄 Configuración clave / Key Configuration

| Archivo / File | Contenido / Content |
|---|---|
| `rebar.config` | `{erl_opts, [debug_info]}`, `{deps, []}` |
| `src/data_structures_advanced.app.src` | Aplicación OTP `data_structures_advanced`, versión `0.1.0` / OTP application `data_structures_advanced`, version `0.1.0` |

---

## 🚀 Compilación y ejecución / Build & Run

```bash
rebar3 compile     # Compila el código fuente del módulo / Compiles module source code
rebar3 eunit       # Compila y ejecuta la suite de pruebas unitarias / Compiles and runs unit test suite
```

**Salida real / Actual output:**

```text
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling data_structures_advanced
===> Performing EUnit tests...
........................
Finished in 0.080 seconds
24 tests, 0 failures
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `tree_node_init/1` | `integer() → tree_node()` | $O(1)$ | Construye `#tree_node{value = Value, left = undefined, right = undefined}` / Builds `#tree_node{value = Value, left = undefined, right = undefined}`. |
| `tree_node_get_value/1` | `tree_node() → integer()` | $O(1)$ | Observa el valor del nodo / Observes node value. No muta / Does not mutate. |
| `tree_node_get_left/1` | `tree_node() → tree_node() \| undefined` | $O(1)$ | Devuelve el enlace izquierdo o `undefined` / Returns left link or `undefined`. |
| `tree_node_get_right/1` | `tree_node() → tree_node() \| undefined` | $O(1)$ | Devuelve el enlace derecho o `undefined` / Returns right link or `undefined`. |
| `tree_node_set_left/2` | `(tree_node(), tree_node() \| undefined) → tree_node()` | $O(1)$ | Devuelve un nuevo nodo con el enlace izquierdo actualizado / Returns a new node with updated left link. |
| `tree_node_set_right/2` | `(tree_node(), tree_node() \| undefined) → tree_node()` | $O(1)$ | Devuelve un nuevo nodo con el enlace derecho actualizado / Returns a new node with updated right link. |
| `binary_tree_init/0` | `() → binary_tree()` | $O(1)$ | Inicializa `#binary_tree{root = undefined, count = 0}` / Initializes `#binary_tree{root = undefined, count = 0}`. |
| `binary_tree_insert/2` | `(binary_tree(), integer()) → binary_tree()` | $O(h)$ | Inserta según invariante de ABB mediante `insert_node/2`; duplicados no incrementan `count` / Inserts respecting BST invariant via `insert_node/2`; duplicates do not increment `count`. |
| `binary_tree_contains/2` | `(binary_tree(), integer()) → boolean()` | $O(h)$ | Búsqueda por ramas de ABB vía `contains_node/2` / BST branch traversal via `contains_node/2`. |
| `binary_tree_is_empty/1` | `binary_tree() → boolean()` | $O(1)$ | Evalúa si `count =:= 0` / Evaluates if `count =:= 0`. |
| `binary_tree_size/1` | `binary_tree() → non_neg_integer()` | $O(1)$ | Devuelve el número de elementos / Returns element count. |
| `graph_init/0` | `() → graph()` | $O(1)$ | Inicializa `#graph{vertices = undefined, vertex_count = 0, edge_count = 0}` / Initializes empty graph. |
| `graph_add_vertex/2` | `(graph(), integer()) → graph()` | $O(V)$ | Registra vértice en registro enlazado canónico si no existe; duplicado no altera contadores / Registers vertex in canonical linked registry if absent; duplicate preserves counts. |
| `graph_add_edge/3` | `(graph(), integer(), integer()) → graph() \| undefined` | $O(V + d(u))$ | Verifica extremos con `find_vertex/2`, inserta ordenado en vecinos con `insert_sorted/2` y actualiza registro persistente con `update_vertex/2`; devuelve `undefined` si falta un extremo / Checks endpoints via `find_vertex/2`, inserts sorted into neighbours via `insert_sorted/2`, and updates persistent registry via `update_vertex/2`; returns `undefined` on missing endpoint. |
| `graph_has_edge/3` | `(graph(), integer(), integer()) → boolean()` | $O(V + d(u))$ | Busca vértice de origen y comprueba pertenencia en vecinos ordenados / Locates source vertex and checks membership in neighbours. |
| `graph_get_neighbors/2` | `(graph(), integer()) → [integer()] \| undefined` | $O(V)$ | Devuelve lista ordenada inmutable de vecinos; devuelve `undefined` si el vértice no existe / Returns immutable sorted neighbour list; returns `undefined` if vertex does not exist. |
| `graph_is_empty/1` | `graph() → boolean()` | $O(1)$ | Evalúa si `vertex_count =:= 0` / Evaluates if `vertex_count =:= 0`. |
| `graph_vertex_count/1` | `graph() → non_neg_integer()` | $O(1)$ | Devuelve el total de vértices / Returns vertex count. |
| `graph_edge_count/1` | `graph() → non_neg_integer()` | $O(1)$ | Devuelve el total de aristas / Returns edge count. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Reutilización de `Node` por valor embebido / `Node` reuse via embedded value | Simulación de herencia con registros anidados (`#node{}`) / Inheritance simulation via nested records (`#node{}`) | Erlang no posee herencia orientada a objetos. Embeber el campo `value` directamente en `#tree_node` y `#graph_node` simplifica el acceso a campos, evita niveles innecesarios de indirección de tuplas y respeta el principio de nodo base sin validaciones / Erlang lacks OOP inheritance. Embedding the `value` field directly in `#tree_node` and `#graph_node` simplifies field access, prevents tuple indirection overhead, and adheres to the validation-free base node contract. |
| Registro canónico de vértices enlazados con `#graph_node.next_vertex` / Canonical linked vertex registry with `#graph_node.next_vertex` | Mapas (`maps:new/0`), diccionarios o tablas ETS / Maps (`maps:new/0`), dictionaries, or ETS tables | La especificación prohíbe el uso de mapas, conjuntos o tablas hash de biblioteca para el registro de vértices; la estructura enlazada persistente garantiza un recorrido manual $O(V)$ conforme al modelo canónico / The specification prohibits library maps, sets, or hash tables for vertex registry; the persistent linked structure guarantees manual $O(V)$ traversal adhering to the canonical model. |
| Representación de ausencia y fallos con `undefined` / Absence and failure representation with `undefined` | Lanzar excepciones (`error(badarg)`) o retornos monádicos (`{ok, V} \| {error, Reason}`) / Throw exceptions (`error(badarg)`) or monadic returns (`{ok, V} \| {error, Reason}`) | La fase actual del monorepo prohíbe excepciones y constructores monádicos. En Erlang `undefined` es el átomo canónico para campos no inicializados y valores ausentes, diferenciándose claramente de una lista vacía `[]` de vecinos / Early monorepo phase forbids exceptions and monadic types. In Erlang `undefined` is the canonical atom for uninitialized fields and absent values, clearly distinct from an empty neighbour list `[]`. |
| Inserción ordenada manual con `insert_sorted/2` / Manual sorted insertion via `insert_sorted/2` | Uso de `lists:sort/1` o `sets` de la biblioteca estándar / Use of `lists:sort/1` or standard library `sets` | La especificación permite usar listas nativas solo para el almacenamiento de vecinos, exigiendo que la búsqueda, detección de duplicados e inserción ordenada sean manuales con coste $O(d(u))$ / Specification allows native lists for neighbour storage only, requiring manual search, duplicate detection, and sorted insertion with $O(d(u))$ cost. |
| Tipos opacos (`-opaque tree_node()`, `-opaque binary_tree()`, `-opaque graph()`) / Opaque types | Exportar los registros en archivos de cabecera `.hrl` / Exporting records in `.hrl` headers | Oculta los detalles de implementación interna de los registros `#tree_node`, `#binary_tree` y `#graph`, garantizando que el acceso se realice exclusivamente a través de la API pública exportada / Hides internal record implementation details, ensuring interaction occurs strictly through the public API. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Herencia de clases (`TreeNode extends Node`, `GraphNode extends Node`) / Class inheritance (`TreeNode extends Node`, `GraphNode extends Node`) | Valor embebido en registros `#tree_node` y `#graph_node` / Embedded value in `#tree_node` and `#graph_node` records | Erlang no soporta herencia de clases; la reutilización del valor se realiza por valor embebido conforme permite la especificación / Erlang does not support class inheritance; value reuse is done via embedded value as permitted by the specification. |
| Mutación in-place en enlaces de árbol y aristas de grafo / In-place mutation of tree links and graph edges | Funciones puras que devuelven nuevas estructuras actualizadas con reconstrucción de caminos / Pure functions returning new updated structures with path reconstruction | En Erlang los términos son inmutables por diseño; `tree_node_set_left/2`, `tree_node_set_right/2`, `binary_tree_insert/2`, `graph_add_vertex/2` y `graph_add_edge/3` devuelven nuevas instancias sin efectos secundarios / In Erlang terms are immutable by design; updating functions return new instances without side effects. |
| Modificación destructiva de la copia devuelta por `get_neighbors` / Destructive modification of copy returned by `get_neighbors` | Aislamiento garantizado por inmutabilidad; la modificación destructiva in-place es no representable / Isolation guaranteed by immutability; in-place destructive modification is not representable | Las listas en Erlang son inmutables por valor; ninguna operación del llamador puede alterar destructivamente la lista devuelta ni el estado interno del grafo / Erlang lists are immutable by value; no caller operation can destructively alter the returned list or the graph's internal state. |
| Indicador de ausencia (`absent`) / Absence indicator (`absent`) | Átomo `undefined` / Atom `undefined` | Representación idiomática y canónica de ausencia en campos de registros en Erlang / Canonical and idiomatic representation of absence in Erlang record fields. |
| Entrada nula o inválida / Null or invalid input | No representable para registros / Not representable for records | Los tipos de registros en Erlang exigen tuplas etiquetadas válidas; pasar `undefined` u otro tipo incompatible provocaría un fallo de pattern matching (`badrecord`), no siendo una entrada representable válida en el sistema de tipos / Record types in Erlang require valid tagged tuples; passing incompatible terms triggers `badrecord`, making generic null inputs non-representable. |
| Ubicación esperada `src/` y `test/` con `run_tests.ext` / Expected location `src/` and `test/` with `run_tests.ext` | `src/` y `test/` estándar con EUnit integrado / Standard `src/` and `test/` with built-in EUnit | Convención canónica de proyectos Erlang con rebar3 / Canonical Erlang project convention with rebar3. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `tree_node_init/1` | No aplica: inicialización / Not applicable: initialization | — | — |
| `tree_node_get_value/1` | No aplica: acceso a campo / Not applicable: field access | — | — |
| `tree_node_get_left/1` | Enlace izquierdo ausente / Left link absent | `undefined` | `tree_node_get_left(Node) =:= undefined` |
| `tree_node_get_right/1` | Enlace derecho ausente / Right link absent | `undefined` | `tree_node_get_right(Node) =:= undefined` |
| `tree_node_set_left/2` | No aplica: actualización / Not applicable: update | — | — |
| `tree_node_set_right/2` | No aplica: actualización / Not applicable: update | — | — |
| `binary_tree_init/0` | No aplica: inicialización / Not applicable: initialization | — | — |
| `binary_tree_insert/2` | Sin fallo por límite contractual / No contractual limit failure | — | — |
| `binary_tree_contains/2` | Valor no encontrado / Value not found | `false` | `binary_tree_contains(Tree, 99) =:= false` |
| `binary_tree_is_empty/1` | No aplica: consulta / Not applicable: query | — | — |
| `binary_tree_size/1` | No aplica: consulta / Not applicable: query | — | — |
| `graph_init/0` | No aplica: inicialización / Not applicable: initialization | — | — |
| `graph_add_vertex/2` | Sin fallo por límite contractual / No contractual limit failure | — | — |
| `graph_add_edge/3` | Vértice origen o destino inexistente / Source or target vertex missing | `undefined` | `graph_add_edge(Graph, 10, 99) =:= undefined` |
| `graph_has_edge/3` | Arista inexistente o vértice inexistente / Missing edge or missing endpoint | `false` | `graph_has_edge(Graph, 10, 99) =:= false` |
| `graph_get_neighbors/2` | Vértice inexistente / Missing vertex | `undefined` | `graph_get_neighbors(Graph, 99) =:= undefined` |
| `graph_is_empty/1` | No aplica: consulta / Not applicable: query | — | — |
| `graph_vertex_count/1` | No aplica: consulta / Not applicable: query | — | — |
| `graph_edge_count/1` | No aplica: consulta / Not applicable: query | — | — |
| Entrada nula o inválida / Null or invalid input | No representable para registros / Not representable for records | — | El sistema de tipos de Erlang no admite valores nulos genéricos para registros / Erlang type system does not allow generic null values for records. |

---

## ✅ Cobertura de pruebas / Test coverage

**ES:** La salida real certifica **24 pruebas unitarias** ejecutadas por EUnit (`rebar3 eunit`), todas exitosas sin fallos. Las pruebas se agrupan en tres unidades lógicas (`TreeNode`, `BinaryTree`, `Graph`) dentro de `test/data_structures_advanced_test.erl`.

**EN:** The real output certifies **24 unit tests** executed by EUnit (`rebar3 eunit`), all passing with zero failures. Tests are grouped into three logical units (`TreeNode`, `BinaryTree`, `Graph`) inside `test/data_structures_advanced_test.erl`.

### `TreeNode` (`test/data_structures_advanced_test.erl`)

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|:--:|---|---|
| Crear un nodo de árbol<br>Create a tree node | Sí / Yes | `tree_node_create_test/0` | Verifica `tree_node_get_value(Node) =:= 10` / Verifies `tree_node_get_value(Node) =:= 10`. |
| Enlaces iniciales ausentes<br>Absent initial links | Sí / Yes | `tree_node_initial_links_absent_test/0` | Verifica que `tree_node_get_left` y `tree_node_get_right` devuelven `undefined` / Verifies left and right links return `undefined`. |
| Enlazar dos hijos<br>Link two children | Sí / Yes | `tree_node_link_two_children_test/0` | Enlaza hijos 20 y 30 y observa valores a través de enlaces / Links children 20 and 30 and observes values via links. |
| Recorrer cada enlace<br>Traverse each link | Sí / Yes | `tree_node_traverse_each_link_test/0` | Recorre enlaces izquierdo y derecho y verifica que los enlaces de los hijos son `undefined` / Traverses left and right links, checking children links are `undefined`. |
| Desenlazar hijos<br>Unlink children | Sí / Yes | `tree_node_unlink_children_test/0` | Desenlaza izquierdo y derecho con `undefined`, verificando preservación de valores / Unlinks left and right with `undefined`, verifying value preservation. |
| Adaptación inmutable (si aplica)<br>Immutable adaptation (if applicable) | Sí / Yes | `tree_node_immutable_set_left_test/0` | Verifica que `tree_node_set_left` devuelve un nuevo nodo sin mutar el original / Verifies `tree_node_set_left` returns a new node without mutating original. |

### `BinaryTree` (`test/data_structures_advanced_test.erl`)

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|:--:|---|---|
| Crear vacío<br>Create empty | Sí / Yes | `binary_tree_create_empty_test/0` | `is_empty =:= true`, `size =:= 0`, `contains(50) =:= false`. |
| Insertar la raíz<br>Insert the root | Sí / Yes | `binary_tree_insert_root_test/0` | Inserción de 50; `size =:= 1`, `is_empty =:= false`, `contains(50) =:= true`. |
| Insertar menor y mayor<br>Insert lower and higher | Sí / Yes | `binary_tree_insert_lower_and_higher_test/0` | Inserción de 50, 30, 70; tamaño 3 y pertenencia de los tres / Inserts 50, 30, 70; size 3, all present. |
| Ramas de varios niveles<br>Multilevel branches | Sí / Yes | `binary_tree_multilevel_branches_test/0` | Inserción de 50, 30, 70, 20, 40; tamaño 5 y pertenencia de todos / Inserts 50, 30, 70, 20, 40; size 5, all present. |
| Valor ausente en árbol no vacío<br>Missing value in nonempty tree | Sí / Yes | `binary_tree_missing_value_nonempty_test/0` | Árbol con 50; `contains(99) =:= false`, tamaño 1 preservado / Tree with 50; `contains(99) =:= false`, size 1 kept. |
| Duplicado idempotente<br>Idempotent duplicate | Sí / Yes | `binary_tree_idempotent_duplicate_test/0` | Inserción de 50, 30, 70, 30; tamaño 3 y pertenencia de los tres valores / Inserts 50, 30, 70, 30; size 3, all three present. |
| Inserciones ordenadas<br>Ordered insertions | Sí / Yes | `binary_tree_ordered_insertions_test/0` | Inserción de 20, 30, 40, 50, 70; tamaño 5 y pertenencia; `contains(99) =:= false`. |

### `Graph` (`test/data_structures_advanced_test.erl`)

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|:--:|---|---|
| Crear vacío<br>Create empty | Sí / Yes | `graph_create_empty_test/0` | `is_empty =:= true`, 0 vértices, 0 aristas; consultas fallan / `is_empty =:= true`, 0 vertices, 0 edges; queries fail. |
| Vértice aislado<br>Isolated vertex | Sí / Yes | `graph_isolated_vertex_test/0` | Vértice 10; no vacío, 1 vértice, 0 aristas, vecinos vacíos `[]` / Vertex 10; not empty, 1 vertex, 0 edges, empty neighbours `[]`. |
| Etiquetas no consecutivas y arista dirigida<br>Nonconsecutive labels and directed edge | Sí / Yes | `graph_nonconsecutive_directed_edge_test/0` | Vértices 10, 70 y arista `(10, 70)`; arista directa presente, inversa ausente; 2 vértices, 1 arista / Forward edge present, reverse absent; 2 vertices, 1 edge. |
| Vértice duplicado conserva adyacencia<br>Duplicate vertex preserves adjacency | Sí / Yes | `graph_duplicate_vertex_preserves_adjacency_test/0` | Re-registro de 10 conserva arista hacia 30; 2 vértices, 1 arista / Re-registering 10 preserves edge to 30; 2 vertices, 1 edge. |
| Arista duplicada<br>Duplicate edge | Sí / Yes | `graph_duplicate_edge_test/0` | `add_edge(10, 30)` dos veces; 2 vértices, 1 arista, vecinos `[30]` / `add_edge(10, 30)` twice; 2 vertices, 1 edge, neighbours `[30]`. |
| Extremo inexistente sin mutación<br>Missing endpoint without mutation | Sí / Yes | `graph_missing_endpoint_without_mutation_test/0` | Intentos con vértices inexistentes devuelven `undefined` sin mutar vértices ni aristas / Attempts with missing endpoints return `undefined` without state change. |
| Vecinos ordenados y contadores<br>Sorted neighbours and counts | Sí / Yes | `graph_sorted_neighbours_and_counts_test/0` | Aristas `(10,70)`, `(10,30)`, `(10,50)`, `(30,50)`; vecinos de 10 ordenados `[30, 50, 70]`; 4 vértices, 4 aristas / Neighbours of 10 sorted `[30, 50, 70]`; 4 vertices, 4 edges. |
| Consulta de arista ausente<br>Missing-edge query | Sí / Yes | `graph_missing_edge_query_test/0` | Consulta de arista `(10, 30)` devuelve `false`; 2 vértices, 0 aristas / Edge query `(10, 30)` returns `false`; 2 vertices, 0 edges. |
| Vecinos de vértice inexistente<br>Neighbours of missing vertex | Sí / Yes | `graph_neighbours_of_missing_vertex_test/0` | `graph_get_neighbors(Graph, 99)` devuelve `undefined`, distinguiéndose de `[]` / Returns `undefined`, distinct from empty list `[]`. |
| Bucle y duplicado<br>Self-loop and duplicate | Sí / Yes | `graph_self_loop_and_duplicate_test/0` | Bucle `(10, 10)` insertado dos veces; 1 vértice, 1 arista, vecinos `[10]` / Loop `(10, 10)` inserted twice; 1 vertex, 1 edge, neighbours `[10]`. |
| Aislamiento del resultado de vecinos<br>Neighbour-result isolation | Sí / Yes | `graph_neighbour_result_isolation_test/0` | Verifica preservación de lista guardada ante inserciones posteriores; mutación destructiva in-place omitida por inmutabilidad / Verifies saved list preserved against later insertions; in-place destructive mutation omitted due to immutability. |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Reconstrucción persistente del registro de vértices en `graph_add_edge/3` ($O(V)$) / Persistent vertex registry reconstruction in `graph_add_edge/3` ($O(V)$) | La actualización de vecinos de un vértice reconstruye el registro enlazado hasta el vértice / Updating neighbours of a vertex reconstructs the linked chain up to the vertex | Es inherente al modelo funcional inmutable con registro enlazado canónico `#graph_node.next_vertex` sin recurrir a mapas mutables o tablas ETS / Inherent to immutable functional model with canonical linked registry `#graph_node.next_vertex` without using mutable maps or ETS. |
| Ausencia de mutación destructiva in-place / Lack of in-place destructive mutation | El paso «modificar otra copia devuelta» del escenario de aislamiento no es directamente ejecutable / The step "modify another returned copy" of isolation scenario is not directly executable | Garantizado por diseño mediante la inmutabilidad de los términos en Erlang: toda lista devuelta por `graph_get_neighbors/2` es inmutable y no puede afectar al grafo / Guaranteed by design via Erlang term immutability: any list returned by `graph_get_neighbors/2` is immutable and cannot mutate the graph. |

---

## 📝 Notas de implementación / Implementation Notes

### 🌳 Inmutabilidad y ABB / Immutability and BST

**ES:** En Erlang todas las estructuras son inmutables por valor. La inserción en el árbol binario de búsqueda (`binary_tree_insert/2`) desciende recursivamente por las ramas según la invariante del ABB; cuando se añade un nuevo nodo, la función reconstruye únicamente los nodos ancestros del camino modificado, compartiendo estructuralmente las ramas no alteradas. Esto mantiene la complejidad temporal en $O(h)$ y la espacial en $O(h)$ por inserción.

**EN:** In Erlang all data structures are immutable by value. Insertion in the binary search tree (`binary_tree_insert/2`) recursively traverses branches respecting the BST invariant; when a new node is created, only ancestor nodes on the path are reconstructed, structurally sharing unchanged subtrees. This preserves $O(h)$ time complexity and $O(h)$ space overhead per insertion.

### 🕸️ Grafo con registro enlazado canónico / Graph with Canonical Linked Registry

**ES:** El grafo cumple estrictamente el requisito de no delegar el registro de vértices en diccionarios o mapas de biblioteca. El registro `#graph.vertices` encadena nodos `#graph_node` mediante el campo `next_vertex`. La búsqueda `find_vertex/2` recorre secuencialmente esta cadena ($O(V)$). Al registrar una arista en `graph_add_edge/3`, se comprueba la existencia de ambos extremos, se inserta ordenadamente el destino en la lista de vecinos mediante `insert_sorted/2` ($O(d(u))$) y se reconstruye la cadena de vértices mediante `update_vertex/2`.

**EN:** The graph strictly satisfies the requirement of not delegating vertex registration to library dictionaries or maps. The `#graph.vertices` field links `#graph_node` records via `next_vertex`. `find_vertex/2` sequentially traverses this chain ($O(V)$). When adding an edge in `graph_add_edge/3`, existence of both endpoints is verified, the target is inserted in order into the neighbour list via `insert_sorted/2` ($O(d(u))$), and the vertex chain is updated via `update_vertex/2`.

### 🌐 Otras implementaciones / Other implementations

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

**EN:** This project is also implemented in other languages. Explore the [main repository](https://github.com/yorche3/programming_languages) to see all the versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README / Native suite was executed and its real output is copied into this README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón) / Each specification case has its row in _Test coverage_ (or `Omitted` with reason).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_ / Each deviation from pseudocode or expected location is in _Idiomatic adaptations_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_ / Each operation with potential failure is in _Failure indicators_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas / No author absolute paths, credentials, or fabricated outputs.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe / Relative links resolve within repository and document is bilingual.
- [x] Ninguna sección repite lo que ya dice la especificación / No section repeats what the specification already states.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/README.md`](../data_structures_basics/README.md) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/README.md`](../../foundations/numbers/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/WORKFLOW/) |
| Plantilla del README / README template | [`README_Template.md`](https://yorche3.github.io/programming_languages/README_Template/) |
| Documentación oficial del lenguaje / Language official docs | [Erlang/OTP Documentation](https://www.erlang.org/doc/) · [Rebar3 Documentation](https://rebar3.org/docs/) |

---

*[← Volver al Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
