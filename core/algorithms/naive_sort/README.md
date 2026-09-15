# Naive Sort — Erlang

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Erlang**, utilizando **rebar3** como sistema de compilación y **EUnit** para las pruebas unitarias.

Este módulo implementa los tres algoritmos elementales de ordenamiento ($O(n^2)$) — **Selection Sort**, **Bubble Sort** e **Insertion Sort** — con recursión y pattern matching, sin invocar `lists:sort/1` ni ninguna función de ordenamiento del sistema.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/naive_sort.erl`](src/naive_sort.erl) | Código fuente: las 3 funciones exportadas y 4 helpers privados. |
| [`test/naive_sort_test.erl`](test/naive_sort_test.erl) | Pruebas unitarias con EUnit: 3 generadores × 7 casos = 21 tests. |
| [`src/naive_sort.app.src`](src/naive_sort.app.src) | Metadatos de la aplicación OTP. |
| [`rebar.config`](rebar.config) | Configuración de rebar3 (compilación). |
| [`.gitignore`](.gitignore) | Artefactos de rebar3 y de Erlang. |
| [`LICENSE.md`](LICENSE.md) | Licencia. |

**Estructura de directorios esperada:**

```text
naive_sort/
├── rebar.config              # Configuración de rebar3
├── src/
│   ├── naive_sort.erl        # Implementación (3 funciones + 4 helpers)
│   └── naive_sort.app.src    # Metadatos OTP
├── test/
│   └── naive_sort_test.erl   # 21 tests (3 algoritmos × 7 casos)
├── _build/                   # Compilados (generado por rebar3)
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó con **rebar3** como sistema de compilación. La estructura sigue la convención estándar de OTP: `src/` para el código fuente y `test/` para las pruebas, con EUnit como framework integrado en Erlang/OTP. Erlang no tiene estructuras mutables, así que los tres algoritmos se expresan con **recursión y cláusulas múltiples**, y cada uno devuelve una lista nueva en lugar de ordenar *in-place*.

**EN:** The project was created with **rebar3** as the build system. The structure follows the standard OTP convention: `src/` for source code and `test/` for tests, with EUnit as the framework built into Erlang/OTP. Erlang has no mutable structures, so all three algorithms are expressed with **recursion and multiple clauses**, and each returns a new list instead of sorting in place.

### Pasos de inicialización:

1. **Crear la estructura**: `rebar3 new lib naive_sort`.
2. **Agregar pruebas**: `test/naive_sort_test.erl` con EUnit.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `rebar.config` – Configuración de build

**ES:** Define las opciones de compilación. En este proyecto solo se usa `debug_info` para incluir información de depuración, igual que en `numbers/`.

**EN:** Defines compilation options. This project only uses `debug_info` to include debugging information, as in `numbers/`.

```erlang
{erl_opts, [debug_info]}.
{deps, []}.
```

### `src/naive_sort.erl` – Implementación

**ES:** El módulo exporta únicamente las tres funciones del contrato. Los helpers (`pick_min`, `rest`, `bubble_pass`, `insert`) son funciones **no exportadas**: en Erlang la privacidad se controla desde la lista `-export/1`, no con una palabra clave. Los casos base se expresan con cláusulas múltiples en lugar de `if`/`else`.

**EN:** The module exports only the three contract functions. The helpers (`pick_min`, `rest`, `bubble_pass`, `insert`) are **non-exported** functions: in Erlang privacy is controlled by the `-export/1` list, not by a keyword. Base cases are expressed with multiple clauses instead of `if`/`else`.

```erlang
-module(naive_sort).

-export([selection_sort/1, bubble_sort/1, insertion_sort/1]).

selection_sort([]) -> [];
selection_sort(List) ->
    MinIdx = pick_min(List),
    [MinIdx | selection_sort(rest(List, MinIdx))].

bubble_sort([]) -> [];
bubble_sort(List) ->
    case bubble_pass(List) of
        {Sorted, true} -> bubble_sort(Sorted);
        {Sorted, false} -> Sorted
    end.

insertion_sort([]) -> [];
insertion_sort([H|T]) -> insert(H, insertion_sort(T)).
```

### `test/naive_sort_test.erl` – Pruebas

**ES:** Los siete casos de la especificación se declaran como **macros con nombre** (`?STANDARD_INPUT`, …) y se agrupan en la función `cases/0`. Un único helper `assert_sorts_all_cases/2` construye, mediante un **generador de EUnit**, un test con nombre para cada caso. Esto hace que cada fallo se identifique en la salida con el mensaje `"selection_sort should sort an unsorted array"`.

**EN:** The seven specification cases are declared as **named macros** (`?STANDARD_INPUT`, …) and grouped in the `cases/0` function. A single `assert_sorts_all_cases/2` helper builds, through an **EUnit generator**, one named test per case. This makes every failure identifiable in the output by the message `"selection_sort should sort an unsorted array"`.

```erlang
-define(STANDARD_INPUT, [5, 2, 9, 1, 5, 6]).
-define(STANDARD_OUTPUT, [1, 2, 5, 5, 6, 9]).

assert_sorts_all_cases(SortFun, Algorithm) ->
    [{Algorithm ++ " should sort " ++ Description,
      fun() -> ?assertEqual(Expected, SortFun(Input)) end}
     || {Description, Input, Expected} <- cases()].

selection_sort_test_() ->
    assert_sorts_all_cases(fun naive_sort:selection_sort/1, "selection_sort").
```

> **ES:** Los generadores de EUnit son las funciones cuyo nombre termina en `_test_` (con guion bajo final) y devuelven una lista de pruebas en lugar de ejecutarse directamente.
> **EN:** EUnit generators are the functions whose name ends in `_test_` (trailing underscore) and return a list of tests instead of running directly.

---

## 🚀 Compilación y ejecución / Build & Run

### Compilar / Build

```bash
cd erlang/core/algorithms/naive_sort
rebar3 compile
```

**Salida real / Actual output:**

```text
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling naive_sort
```

### Ejecutar pruebas / Run tests

```bash
rebar3 eunit
```

**Salida real / Actual output:**

```text
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling naive_sort
===> Performing EUnit tests...
.....................
Finished in 0.068 seconds
21 tests, 0 failures
```

---

## 🧠 Algoritmos / operaciones

| Función | Estrategia | Complejidad | In-place | Tests |
|---------|-----------|-------------|:--------:|:-----:|
| `selection_sort/1` | `pick_min/1` extrae el mínimo y lo antepone al resultado de ordenar el resto | $O(n^2)$ siempre | ❌ (lista nueva) | 7 |
| `bubble_sort/1` | Repite `bubble_pass/1`; se detiene cuando una pasada no intercambia nada | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ (lista nueva) | 7 |
| `insertion_sort/1` | Ordena la cola y luego inserta la cabeza con `insert/2` | $O(n^2)$ peor/promedio, $O(n)$ mejor | ❌ (lista nueva) | 7 |

| Helper privado | Papel |
|----------------|-------|
| `pick_min/1` | Recorre la lista y devuelve el menor elemento. |
| `rest/2` | Devuelve la lista sin la **primera** aparición del elemento indicado. |
| `bubble_pass/1` | Una pasada de burbuja; devuelve `{Lista, Swapped}`. |
| `insert/2` | Inserta un entero en una lista ya ordenada. |

**Casos cubiertos:** lista desordenada, ya ordenada, en orden inverso, elementos idénticos, con negativos, un solo elemento y lista vacía.

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Divergencias idiomáticas respecto al pseudocódigo / Idiomatic divergences from the pseudocode

| Pseudocódigo | Erlang | Motivo / Reason |
|--------------|--------|-----------------|
| `swap(arr, i, min_idx)` *in-place* | Se construye una lista nueva | Los términos de Erlang son inmutables (single assignment) / Erlang terms are immutable |
| Bucles `for` / `while` | Recursión con cláusulas múltiples | Erlang no tiene bucles imperativos / Erlang has no imperative loops |
| `swapped = false` mutado durante la pasada | `bubble_pass/1` devuelve `{Lista, Swapped}` | Equivalente funcional de la bandera; conserva la salida temprana / Functional equivalent of the flag; keeps the early exit |
| `if n <= 1` | Cláusula `selection_sort([])` | Pattern matching idiomático / Idiomatic pattern matching |
| `if min_idx != i` (evita el swap) | Para listas de tamaño ≤ 1 no hay recursión | El ahorro es implícito en el patrón / The saving is implicit in the pattern |

**ES:** `rest/2` elimina la **primera** aparición del mínimo, no una posición concreta. El comportamiento observable coincide con el contrato porque ese valor es el que acaba de extraerse con `pick_min/1`.

**EN:** `rest/2` removes the **first** occurrence of the minimum, not a specific position. The observable behavior matches the contract because that value is the one just extracted by `pick_min/1`.

### 🚫 Caso nulo / Null case

**ES:** El caso nulo de la especificación **se omite** porque Erlang no tiene `null`/`nil` y el tipo `list()` no puede representar una entrada inválida: no existe tal entrada. La justificación está documentada en `test/naive_sort_test.erl`. Una llamada con un término que no sea lista queda fuera del contrato y provoca un `function_clause`; no se prueba por ese motivo.

**EN:** The specification's null case **is omitted** because Erlang has no `null`/`nil` and the `list()` type cannot represent an invalid input: no such input exists. The rationale is documented in `test/naive_sort_test.erl`. A call with a non-list term falls outside the contract and raises `function_clause`; it is not tested for that reason.

### 📁 Desviación de ubicación / Location deviation

**ES:** La especificación espera un `run_tests.ext`. Erlang no lo necesita: `rebar3 eunit` descubre y ejecuta automáticamente todos los módulos `*_test.erl` de `test/`. Los nombres de archivo (`src/naive_sort.erl`, `test/naive_sort_test.erl`) y la separación `src/` ↔ `test/` sí coinciden con lo esperado, y el *naming* es el idiomático de Erlang (`snake_case`, funciones `nombre/aridad`).

**EN:** The specification expects a `run_tests.ext`. Erlang does not need one: `rebar3 eunit` automatically discovers and runs every `*_test.erl` module under `test/`. The file names (`src/naive_sort.erl`, `test/naive_sort_test.erl`) and the `src/` ↔ `test/` separation do match the expected layout, and the naming is Erlang's idiomatic style (`snake_case`, `name/arity` functions).

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*[← Volver a Algorithms Pure](README.md) | [↑ Volver a Erlang Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
