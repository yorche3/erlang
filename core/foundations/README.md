# Erlang Foundations

> **Core Foundations** — Proyectos de fundamentos implementados en **Erlang** (compilado con **erlc**/**rebar3**, ejecutado en la BEAM VM).

Este directorio contiene las implementaciones en Erlang de los proyectos de la sección **Core Foundations** del [repositorio principal](https://github.com/yorche3/programming_languages). Cada subdirectorio es un proyecto independiente que demuestra conceptos progresivos del lenguaje.

---

## 📂 Estructura

```text
erlang/core/foundations/
├── README.md                       # Este archivo
├── helloworld/                     # 01_Hello_World
│   ├── hello_world.erl
│   └── README.md
├── hellouser/                      # 02_Hello_User
│   ├── hello_user.erl
│   └── README.md
├── unit_test/
│   └── calculator/                 # 03_Unit_Test_Calculator
│       ├── rebar.config
│       ├── src/calculator.erl
│       ├── test/calculator_test.erl
│       └── README.md
└── numbers/                        # 04_Numbers
    ├── rebar.config
    ├── src/numbers.erl
    ├── test/
    │   ├── numbers_rec_test.erl
    │   └── numbers_acc_test.erl
    └── README.md
```

---

## 📋 Proyectos

| # | Proyecto | Descripción | Conceptos clave |
|---|----------|-------------|-----------------|
| [01](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | Salida por consola: `"Hello World! from Erlang"` | `io:fwrite/1`, compilación con `erlc`, función `main/0`, BEAM VM |
| [02](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | Lectura de nombre desde stdin y saludo personalizado | `io:get_line/1`, `io:fwrite/2`, formato `~s`, asignación inmutable |
| [03](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | 5 operaciones aritméticas con pruebas unitarias | `rebar3`, EUnit, `?assertEqual`, cláusulas múltiples, guardas (`when`), aridad |
| [04](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | 5 algoritmos matemáticos en 2 enfoques (rec y acc) | Tail recursion con TCO garantizado, pattern matching, `div`/`rem`, acumuladores |

---

## 🚀 Compilación y ejecución

### Requisito

```bash
# Verificar Erlang/OTP
erl -version

# Verificar rebar3 (para calculator y numbers)
rebar3 --version
```

### Proyectos sin rebar3 (`helloworld/`, `hellouser/`)

Estos proyectos se compilan con `erlc` directamente.

```bash
cd erlang/core/foundations/helloworld
erlc hello_world.erl
erl -noshell -s hello_world main -s init stop
```

```bash
cd erlang/core/foundations/hellouser
erlc hello_user.erl
erl -noshell -s hello_user main -s init stop
```

### Proyectos con rebar3 (`calculator/`, `numbers/`)

Estos proyectos usan **rebar3** como sistema de compilación y **EUnit** como framework de pruebas.

```bash
cd erlang/core/foundations/unit_test/calculator
rebar3 compile
rebar3 eunit
```

```bash
cd erlang/core/foundations/numbers
rebar3 compile
rebar3 eunit
```

---

## 🧠 Particularidades de Erlang en estos proyectos

### TCO garantizado

A diferencia de muchos lenguajes, **Erlang/OTP garantiza Tail Call Optimization (TCO)**. La BEAM VM está diseñada específicamente para optimizar llamadas de cola. Esto es fundamental para la concurrencia masiva (cientos de miles de procesos) y para implementar iteración mediante recursión con acumulador.

Todos los proyectos con enfoque `_acc` se benefician de esta garantía y tienen tests unitarios completos.

### Sin versión iterativa explícita

Erlang no tiene construcciones de bucle `for`/`while`. La forma idiomática de "iterar" es mediante recursión con acumulador (tail recursion), que la BEAM convierte automáticamente en saltos (`jump`) en lugar de llamadas (`call`).

Por esta razón, los proyectos `numbers/` solo implementan 2 enfoques (`_rec` y `_acc`), no 3 como en otros lenguajes. El enfoque `_acc` cumple el rol de la versión iterativa.

### Herramientas

| Herramienta | Propósito |
|-------------|-----------|
| `erlc` | Compilador de Erlang a bytecode BEAM (`.beam`) |
| `erl` | Shell interactivo y ejecutor de la BEAM VM |
| `rebar3` | Sistema de compilación y gestión de dependencias |
| EUnit | Framework de testing integrado en OTP |

---

## 🌐 Otras implementaciones

Estos proyectos también están implementados en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
