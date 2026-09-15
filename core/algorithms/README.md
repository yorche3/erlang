# Erlang Algorithms Pure

> **Proyectos de algoritmos puros de Erlang** — Fase 1 del [repositorio principal](https://github.com/yorche3/programming_languages).

Este directorio agrupa las implementaciones de **Erlang/OTP** de la Fase 1 — Algoritmos Puros. Los módulos trabajan sobre listas (`list()`), que en Erlang son inmutables: ningún algoritmo ordena *in-place*.

---

## 📂 Estructura

```text
erlang/core/algorithms/
├── README.md              # Este archivo
└── naive_sort/            # 05_Naive_Sort
    ├── rebar.config
    ├── src/
    │   ├── naive_sort.erl
    │   └── naive_sort.app.src
    ├── test/
    │   └── naive_sort_test.erl
    └── README.md
```

---

## 📋 Proyectos

| # | Proyecto | Descripción | Herramientas | Tests |
|---|----------|-------------|--------------|:-----:|
| [05](naive_sort/) | Naive Sort | Selection, Bubble e Insertion Sort ($O(n^2)$) | `rebar3`, EUnit | 21 |

---

## 🛠️ Herramientas utilizadas

| Herramienta | Uso |
|-------------|-----|
| **`rebar3`** | Sistema de compilación y ejecución de tests |
| **EUnit** | Framework de testing integrado en OTP |
| **`erl`** | Ejecución en la BEAM VM |

---

## 🧭 Patrón común

| Característica | Descripción |
|---------------|-------------|
| **Estructura** | `src/` para el código, `test/` para las pruebas (`rebar3 new lib`) |
| **Módulo** | Un `.erl` por proyecto, con `-export/1` restringido a las funciones del contrato |
| **Tests** | `*_test.erl` con `-include_lib("eunit/include/eunit.hrl")` |
| **Generadores** | Funciones `*_test_()` que devuelven listas de tests con nombre |
| **Recursión** | Sustituye a los bucles; la BEAM garantiza TCO |
| **Inmutabilidad** | Ninguna función muta la lista recibida: devuelven una lista nueva |
| **Indicador de fallo** | No aplica: `list()` no admite entradas nulas |

---

## 🚀 Compilación rápida

```bash
cd naive_sort
rebar3 compile && rebar3 eunit
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Erlang Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
