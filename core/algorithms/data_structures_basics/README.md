# Data Structures Basics — Erlang

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Erlang**, estructurada como biblioteca OTP estándar compilada con **rebar3** y verificada con pruebas unitarias en **EUnit**.

Implementation of the [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) specification in **Erlang**, structured as a standard OTP library built with **rebar3** and verified with **EUnit** unit tests.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / File | Propósito / Purpose |
|---|---|
| [`src/data_structures_basics.erl`](src/data_structures_basics.erl) | Implementación de la celda `cell` y los ADT `linked_list`, `stack` y `queue` / Implementation of `cell` record and `linked_list`, `stack`, and `queue` ADTs |
| [`src/data_structures_basics.app.src`](src/data_structures_basics.app.src) | Metadatos de la aplicación OTP / OTP application metadata |
| [`test/data_structures_basics_test.erl`](test/data_structures_basics_test.erl) | Suite de pruebas unitarias con EUnit (23 pruebas) / EUnit unit test suite (23 tests) |
| [`rebar.config`](rebar.config) | Configuración de compilación para rebar3 / Compilation configuration for rebar3 |
| [`.gitignore`](.gitignore) | Exclusiones de artefactos generados por rebar3 y Erlang (`_build/`, etc.) / Git exclusions for rebar3 and Erlang build artifacts (`_build/`, etc.) |
| [`LICENSE.md`](LICENSE.md) | Licencia del proyecto / Project license |

**Estructura de directorios / Directory structure:**

```text
data_structures_basics/
├── rebar.config                     # Configuración de compilación / Build configuration
├── LICENSE.md                       # Licencia / License
├── .gitignore                       # Exclusiones de Git / Git exclusions
├── src/
│   ├── data_structures_basics.erl   # Módulo principal / Main module
│   └── data_structures_basics.app.src # Metadatos OTP / OTP metadata
└── test/
    └── data_structures_basics_test.erl # Suite de pruebas EUnit / EUnit test suite
```

**Desviación respecto a la ubicación esperada / Deviation from expected location:**

**ES:** La especificación propone `src/data_structures_basics.ext` y una carpeta `test/` (singular) con un ejecutable `run_tests.ext`. En Erlang/OTP y rebar3, la convención canónica ubica el código fuente de la biblioteca en `src/` y la suite de pruebas en `test/` con sufijo `_test.erl`, ejecutándose directamente con `rebar3 eunit`.

**EN:** The specification suggests `src/data_structures_basics.ext` and a `test/` (singular) folder with a `run_tests.ext` runner. In Erlang/OTP and rebar3, canonical layout places library sources under `src/` and the test suite under `test/` with `_test.erl` suffix, executed directly via `rebar3 eunit`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El módulo se creó con la plantilla de biblioteca de rebar3 (`rebar3 new lib data_structures_basics`) y se aplanó en el directorio del módulo. Dado que Erlang es un lenguaje funcional puro e inmutable, los registros no se mutan en memoria; cada operación devuelve una nueva instancia con los enlaces actualizados. `stack` y `queue` se implementaron como ADTs independientes sobre el mismo registro `#cell{}`, sin delegar en `linked_list`.

**EN:** The module was scaffolded using the rebar3 library template (`rebar3 new lib data_structures_basics`) and flattened into the module directory. Since Erlang is a purely functional immutable language, records are never mutated in place; each operation returns a new instance with updated links. `stack` and `queue` were implemented as independent ADTs over the shared `#cell{}` record without delegating to `linked_list`.

---

## 📄 Configuración clave / Key Configuration

| Archivo / File | Contenido / Content |
|---|---|
| `rebar.config` | `{erl_opts, [debug_info]}`, `{deps, []}` |
| `src/data_structures_basics.app.src` | Aplicación OTP `data_structures_basics`, versión `0.1.0` / OTP application `data_structures_basics`, version `0.1.0` |

---

## 🚀 Compilación y ejecución / Build & Run

```bash
rebar3 compile     # Compila el código fuente del módulo / Compiles module source code
rebar3 eunit       # Compila y ejecuta la suite de pruebas unitarias / Compiles and runs unit test suite
```

**Salida real / Actual output:**

```text
$ rebar3 eunit
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling data_structures_basics
===> Performing EUnit tests...
.......................
Finished in 0.075 seconds
23 tests, 0 failures
```

**ES:** Salida copiada de la última ejecución real del 2026-10-03. El acta de evidencia del sprint se encuentra en [`docs/evidence/algorithms/data_structures_basics/erlang.md`](https://github.com/yorche3/programming_languages/blob/main/docs/evidence/algorithms/data_structures_basics/erlang.md).

**EN:** Output copied from the last real run on 2026-10-03. The sprint evidence record is at [`docs/evidence/algorithms/data_structures_basics/erlang.md`](https://github.com/yorche3/programming_languages/blob/main/docs/evidence/algorithms/data_structures_basics/erlang.md).

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `node_init/1` | `integer() → cell()` | `O(1)` | Construye `#cell{value = Value, next = undefined}` / Builds `#cell{value = Value, next = undefined}`. |
| `node_get_value/1` | `cell() → integer()` | `O(1)` | Observa el valor almacenado / Observes stored value. No muta / Does not mutate. |
| `node_get_next/1` | `cell() → cell() \| undefined` | `O(1)` | Devuelve el enlace siguiente o `undefined` / Returns next link or `undefined`. |
| `node_set_next/2` | `(cell(), cell() \| undefined) → cell()` | `O(1)` | Devuelve una celda nueva con el enlace actualizado / Returns a new cell with updated link. |
| `linked_list_init/0` | `() → linked_list()` | `O(1)` | Inicializa `#linked_list{head = undefined, tail = undefined, count = 0}`. |
| `linked_list_get_head/1` | `linked_list() → integer()` | `O(1)` | Devuelve el valor de la cabeza o `-1` si está vacía / Returns head value or `-1` if empty. |
| `linked_list_insert_head/2` | `(linked_list(), integer()) → linked_list()` | `O(1)` | Inserta celda al inicio y actualiza `head`/`tail` / Inserts cell at head and updates `head`/`tail`. |
| `linked_list_insert_tail/2` | `(linked_list(), integer()) → linked_list()` | `O(n)` | Reconstruye la cadena hasta la última celda vía `append_last/2` / Rebuilds chain to tail via `append_last/2`. |
| `linked_list_delete/2` | `(linked_list(), integer()) → {boolean(), linked_list()} \| {boolean(), empty}` | `O(n)` | Elimina la primera aparición vía `remove_first/2` y recalcula `tail` / Removes first occurrence and updates `tail`. |
| `linked_list_is_empty/1` | `linked_list() → boolean()` | `O(1)` | Evalúa si `count =:= 0` / Evaluates if `count =:= 0`. |
| `linked_list_size/1` | `linked_list() → non_neg_integer()` | `O(1)` | Devuelve el contador de elementos / Returns element count. |
| `stack_init/0` | `() → stack()` | `O(1)` | Inicializa `#stack{top = undefined, count = 0}`. |
| `stack_push/2` | `(stack(), integer()) → stack()` | `O(1)` | Inserta una nueva celda en `top` / Pushes new cell to `top`. |
| `stack_peek/1` | `stack() → integer()` | `O(1)` | Observa el valor en `top` sin mutar; `-1` si está vacía / Peeks `top` value without mutating; `-1` if empty. |
| `stack_pop/1` | `stack() → {integer(), stack()} \| {integer(), empty}` | `O(1)` | Extrae y devuelve `{Value, NewStack}`, o `{-1, empty}` si está vacía / Pops `{Value, NewStack}`, or `{-1, empty}` if empty. |
| `stack_is_empty/1` | `stack() → boolean()` | `O(1)` | Evalúa si `count =:= 0` / Evaluates if `count =:= 0`. |
| `stack_size/1` | `stack() → non_neg_integer()` | `O(1)` | Devuelve el contador de elementos / Returns element count. |
| `queue_init/0` | `() → queue()` | `O(1)` | Inicializa `#queue{front = undefined, rear = undefined, count = 0}`. |
| `queue_enqueue/2` | `(queue(), integer()) → queue()` | `O(n)` | Reconstruye la cadena desde `front` vía `append_last/2` / Rebuilds chain from `front` via `append_last/2`. |
| `queue_peek/1` | `queue() → integer()` | `O(1)` | Observa el valor en `front` sin mutar; `-1` si está vacía / Peeks `front` value without mutating; `-1` if empty. |
| `queue_dequeue/1` | `queue() → {integer(), queue()} \| {integer(), empty}` | `O(1)` | Extrae y devuelve `{Value, NewQueue}`, o `{-1, empty}` si está vacía / Dequeues `{Value, NewQueue}`, or `{-1, empty}` if empty. |
| `queue_is_empty/1` | `queue() → boolean()` | `O(1)` | Evalúa si `count =:= 0` / Evaluates if `count =:= 0`. |
| `queue_size/1` | `queue() → non_neg_integer()` | `O(1)` | Devuelve el contador de elementos / Returns element count. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Indicador de fallo `-1` y átomo `empty` en tuplas / Failure indicator `-1` and `empty` atom in tuples | Lanzar excepciones (`error(badarg)`) o retornos monádicos (`{ok, V} \| error`) / Throw exceptions (`error(badarg)`) or monadic returns (`{ok, V} \| error`) | La fase actual del monorepo prohíbe excepciones y retornos monádicos; las operaciones escalares devuelven `-1` y las operaciones con tuplas devuelven `empty` como estado resultante no ambiguo / Early monorepo phase forbids exceptions and monadic types; scalar operations return `-1` and tuple operations return `empty` as unambiguous state. |
| Retorno de tuplas `{Resultado, NuevaEstructura}` / Return tuples `{Result, NewStructure}` | Procesos con estado mutable (`gen_server`) o tablas ETS / Stateful processes (`gen_server`) or ETS tables | Erlang es inmutable por valor; para mantener el diseño como biblioteca pura y funcional sin procesos de fondo ni efectos secundarios, las operaciones mutantes retornan la nueva estructura junto con el resultado / Erlang is immutable by value; to keep a pure functional library without background processes or side effects, state-changing operations return the new structure alongside the result. |
| Registro `#cell{}` compartido como celda única / Shared `#cell{}` record as single cell | Registros específicos de nodo para cada estructura / Dedicated node records per structure | La especificación exige que `Node` sea el tipo de celda compartido y que `stack` y `queue` mantengan sus propios punteros independientes / Specification requires `Node` as the shared cell type, with `stack` and `queue` managing independent pointers. |
| Representación de ausencia con `undefined` / Absence representation with `undefined` | El átomo `nil` o `none` / Atom `nil` or `none` | `undefined` es el valor por defecto estándar de los campos de registros en Erlang / `undefined` is the standard default value for uninitialized record fields in Erlang. |
| Tipos opacos (`-opaque cell()`, etc.) / Opaque types (`-opaque cell()`, etc.) | Registros exportados directamente en cabeceras / Raw records exported directly in headers | Oculta la estructura interna de los registros `#cell`, `#linked_list`, `#stack` y `#queue` fuera del módulo, garantizando que el acceso ocurra únicamente por las funciones del contrato / Encapsulates internal record structures outside the module, ensuring access strictly through contract functions. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Mutabilidad in-place ($O(1)$ en inserción en cola y encolar) / In-place mutation ($O(1)$ in tail insert and enqueue) | Complejidad $O(n)$ en `linked_list_insert_tail/2` y `queue_enqueue/2` mediante reconstrucción de camino (`append_last/2`) / $O(n)$ complexity in `linked_list_insert_tail/2` and `queue_enqueue/2` via path reconstruction (`append_last/2`) | **Nota Aclaratoria de Inmutabilidad:** Erlang carece de mutabilidad en memoria y punteros mutables. Para respetar el contrato del módulo de modelar las estructuras sobre celdas enlazadas individuales `#cell{value, next}` (en lugar de listas nativas de Erlang), añadir un elemento al final requiere copiar y reconstruir la cadena desde la cabeza hasta el final, lo que eleva la complejidad temporal a $O(n)$ / **Immutability Clarifying Note:** Erlang lacks mutable memory and mutable pointers. To satisfy the specification requirement of modeling structures over individual linked `#cell{value, next}` records (rather than native Erlang lists), appending to the tail requires copying and rebuilding the chain from head to tail, resulting in $O(n)$ complexity. |
| Métodos orientados a objetos con mutación de `this` / Object-oriented methods mutating `this` | Funciones puras con prefijo de estructura que devuelven la estructura actualizada / Pure functions with structure prefix returning updated structure | Modelo de programación funcional de Erlang: las funciones reciben la estructura y devuelven una nueva versión sin efectos colaterales / Erlang functional programming model: functions take the structure and return a new instance with no side effects. |
| `Node.init(value)` y métodos de acceso / `Node.init(value)` and access methods | Funciones `node_init/1`, `node_get_value/1`, `node_get_next/1`, `node_set_next/2` / Functions `node_init/1`, `node_get_value/1`, `node_get_next/1`, `node_set_next/2` | Convención funcional con nombres en `snake_case` exportados desde el módulo / Functional convention with `snake_case` names exported from module. |
| Ausencia nativa de enlace / Native link absence | Átomo `undefined` / Atom `undefined` | Representación canónica de ausencia en registros Erlang / Canonical representation of absence in Erlang records. |
| Entrada nula o inválida / Null or invalid input | No representable para registros / Not representable for records | En Erlang los tipos de registros exigen tuplas etiquetadas válidas; pasar `undefined` o un tipo incompatible causaría un error de pattern matching (`badrecord`), por lo que no es una entrada representable válida en el sistema de tipos / In Erlang record types require tagged tuples; passing `undefined` or incompatible types causes a pattern matching error (`badrecord`), making it non-representable. |
| Ubicación esperada `src/` y `test/` con `run_tests.ext` / Expected location `src/` and `test/` with `run_tests.ext` | `src/` y `test/` estándar con EUnit integrado / Standard `src/` and `test/` with built-in EUnit | Convención nativa de proyectos de Erlang con rebar3 / Native project convention in Erlang with rebar3. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `node_init/1` | No aplica: inicialización / Not applicable: initialization | — | — |
| `linked_list_get_head/1` | Lista vacía / Empty list | `-1` | `linked_list_get_head(Empty) =:= -1` |
| `linked_list_delete/2` | Lista vacía / Empty list | `{false, empty}` | `linked_list_delete(Empty, 10) =:= {false, empty}` |
| `linked_list_delete/2` | Valor no encontrado / Value not found | `{false, List}` | `linked_list_delete(List, 99) =:= {false, List}` |
| `stack_peek/1` | Pila vacía / Empty stack | `-1` | `stack_peek(Empty) =:= -1` |
| `stack_pop/1` | Pila vacía / Empty stack | `{-1, empty}` | `stack_pop(Empty) =:= {-1, empty}` |
| `queue_peek/1` | Cola vacía / Empty queue | `-1` | `queue_peek(Empty) =:= -1` |
| `queue_dequeue/1` | Cola vacía / Empty queue | `{-1, empty}` | `queue_dequeue(Empty) =:= {-1, empty}` |
| Entrada nula o inválida / Null or invalid input | No representable para registros / Not representable for records | — | No aplica: el sistema de tipos de Erlang no admite valores nulos genéricos para registros / Not applicable: Erlang type system does not allow generic null values for records. |

---

## ✅ Cobertura de pruebas / Test coverage

**ES:** La salida real certifica **23 pruebas unitarias** ejecutadas por EUnit (`rebar3 eunit`), todas exitosas sin fallos.

**EN:** The real output certifies **23 unit tests** executed by EUnit (`rebar3 eunit`), all passing with zero failures.

### `Node` (`test/data_structures_basics_test.erl`)

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|:--:|---|---|
| Inicializar y observar valor/enlace<br>Initialize and observe value/link | Sí / Yes | `node_init_test`, `node_get_value_test`, `node_get_next_test` | Comprueba `node_get_value(N) =:= 10` y `node_get_next(N) =:= undefined` / Checks `node_get_value(N) =:= 10` and `node_get_next(N) =:= undefined`. |
| Inicializar otro nodo, enlazar y recorrer<br>Initialize another node, link, and traverse | Sí / Yes | `node_set_next_test` | Comprueba `node_set_next/2` y recorrido hasta el valor `20` / Checks `node_set_next/2` and traversal to value `20`. |

### `LinkedList` (`test/data_structures_basics_test.erl`)

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|:--:|---|---|
| Estado vacío<br>Empty state | Sí / Yes | `linked_list_init_test`, `linked_list_is_empty_test`, `linked_list_size_test`, `linked_list_get_head_test` | `is_empty =:= true`, `size =:= 0`, `get_head =:= -1`. |
| Insertar por ambos extremos<br>Insert at both ends | Sí / Yes | `linked_list_insert_head_test`, `linked_list_insert_tail_test` | Inserciones en ambos extremos; `size =:= 4`, cabeza `5` / Both ends insertion; `size =:= 4`, head `5`. |
| Eliminar primera aparición<br>Delete first occurrence | Sí / Yes | `linked_list_delete_test` | Elimina primera aparición de `10`; tamaño pasa a `3` / Deletes first occurrence of `10`; size becomes `3`. |
| Valor ausente<br>Absent value | Sí / Yes | `linked_list_delete_test` | Intento de borrar `99` retorna `{false, List}` sin mutar estado / Deleting `99` returns `{false, List}` without state change. |
| Vaciar<br>Emptying list | Sí / Yes | `linked_list_delete_test` | Eliminación sucesiva hasta vaciar; `is_empty =:= true`, `size =:= 0`, `get_head =:= -1` / Successive deletion to empty. |

### `Stack` (`test/data_structures_basics_test.erl`)

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|:--:|---|---|
| Estado vacío y extracción fallida<br>Empty state and failed extraction | Sí / Yes | `stack_init_test`, `stack_is_empty_test`, `stack_size_test`, `stack_peek_test`, `stack_pop_test` | `peek =:= -1`, `pop =:= {-1, empty}`, estado vacío preservado / `peek =:= -1`, `pop =:= {-1, empty}`, empty state preserved. |
| LIFO y peek no mutante<br>LIFO and non-mutating peek | Sí / Yes | `stack_push_test`, `stack_peek_test` | `push` de 10, 20, 30; `peek =:= 30`, `size =:= 3` / `push` of 10, 20, 30; `peek =:= 30`, `size =:= 3`. |
| Extracción y reutilización<br>Extraction and reuse | Sí / Yes | `stack_pop_test` | `pop` de 30, `push` de 40, vaciado sucesivo (40, 20, 10) / `pop` of 30, `push` of 40, successive emptying (40, 20, 10). |
| Vacío tras extracción<br>Empty after extraction | Sí / Yes | `stack_pop_test` | `pop` sobre pila vaciada retorna `{-1, empty}` y `is_empty =:= true` / `pop` on emptied stack returns `{-1, empty}` and `is_empty =:= true`. |

### `Queue` (`test/data_structures_basics_test.erl`)

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|:--:|---|---|
| Estado vacío y extracción fallida<br>Empty state and failed extraction | Sí / Yes | `queue_init_test`, `queue_is_empty_test`, `queue_size_test`, `queue_peek_test`, `queue_dequeue_test` | `peek =:= -1`, `dequeue =:= {-1, empty}`, estado vacío preservado / `peek =:= -1`, `dequeue =:= {-1, empty}`, empty state preserved. |
| FIFO y peek no mutante<br>FIFO and non-mutating peek | Sí / Yes | `queue_enqueue_test`, `queue_peek_test` | `enqueue` de 10, 20, 30; `peek =:= 10`, `size =:= 3` / `enqueue` of 10, 20, 30; `peek =:= 10`, `size =:= 3`. |
| Extracción y reutilización<br>Extraction and reuse | Sí / Yes | `queue_dequeue_test` | `dequeue` de 10, `enqueue` de 40, vaciado sucesivo (20, 30, 40) / `dequeue` of 10, `enqueue` of 40, successive emptying (20, 30, 40). |
| Vacío tras extracción<br>Empty after extraction | Sí / Yes | `queue_dequeue_test` | `dequeue` sobre cola vaciada retorna `{-1, empty}` y `is_empty =:= true` / `dequeue` on emptied queue returns `{-1, empty}` and `is_empty =:= true`. |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Complejidad $O(n)$ en inserción al final (`linked_list_insert_tail/2` y `queue_enqueue/2`) / $O(n)$ complexity in tail insertion (`linked_list_insert_tail/2` and `queue_enqueue/2`) | Operaciones de cola crecen linealmente con el tamaño de la estructura / Tail operations scale linearly with structure size | Es una limitación inherente a representar estructuras enlazadas sobre celdas inmutables `#cell{}` sin mutabilidad en memoria. En producción, una cola idiomática en Erlang se implementa con un par de listas nativas `[In, Out]` ($O(1)$ amortizado), pero aquí se prioriza cumplir el contrato de celda única `Node` / Inherent limitation of immutable linked cells without mutable heap pointers. In production, an idiomatic Erlang queue uses a two-list pair `[In, Out]` (amortized $O(1)$), but the shared `Node` cell contract is prioritized here. |
| Recursión de cuerpo en `append_last/2` y `remove_first/2` / Body recursion in `append_last/2` and `remove_first/2` | Consume pila lineal proporcional al número de elementos / Uses stack proportional to element count | Aceptable para el alcance de estructuras elementales y suites de prueba; para colecciones masivas se utilizaría recursión de cola con acumulador y `lists:reverse/1` / Acceptable for basic data structures scope and test suites; mass collections would use tail recursion with accumulator and `lists:reverse/1`. |

---

## 📝 Notas de implementación / Implementation Notes

### 🧱 Inmutabilidad y persistencia de celdas / Immutability and Cell Persistence

**ES:** En Erlang todas las estructuras de datos son inmutables. Al llamar a `node_set_next(Cell, Next)`, Erlang no muta la celda original en el heap, sino que crea un nuevo registro `#cell{value = Cell#cell.value, next = Next}`. Por esta razón, cualquier operación que inserte o elimine celdas al final de una cadena debe reconstruir el camino desde la raíz hacia adelante (`append_last/2`), devolviendo una nueva raíz.

**EN:** In Erlang all data structures are immutable. When calling `node_set_next(Cell, Next)`, Erlang does not mutate the original heap cell, but creates a new `#cell{value = Cell#cell.value, next = Next}` record. For this reason, any operation that inserts or deletes cells at the end of a chain must reconstruct the path from root forward (`append_last/2`), returning a new root.

### 🧪 Suite de pruebas con EUnit / EUnit Test Suite

**ES:** La suite en `test/data_structures_basics_test.erl` consta de 23 pruebas individuales que validan el comportamiento observable de cada una de las 22 funciones exportadas. Cada prueba crea instancias limpias y encadena operaciones sucesivas para verificar el contrato sin reiniciar la instancia.

**EN:** The test suite in `test/data_structures_basics_test.erl` comprises 23 individual tests validating the observable behavior of each of the 22 exported functions. Each test creates clean instances and chains successive operations to verify the contract without resetting the instance.

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
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) |
| Acta de evidencia / Evidence record | [`docs/evidence/algorithms/data_structures_basics/erlang.md`](https://github.com/yorche3/programming_languages/blob/main/docs/evidence/algorithms/data_structures_basics/erlang.md) |
| Módulo homologado del lenguaje / Homologated module | [`../naive_sort/README.md`](../naive_sort/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/WORKFLOW/) |
| Plantilla del README / README template | [`README_Template.md`](https://yorche3.github.io/programming_languages/README_Template/) |
| Documentación oficial del lenguaje / Language official docs | [Erlang/OTP Documentation](https://www.erlang.org/doc/) · [Rebar3 Documentation](https://rebar3.org/docs/) |

---

*[← Volver al Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
