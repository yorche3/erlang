# Erlang

> **Lenguaje de programación Erlang/OTP** — Implementaciones de proyectos educativos en la BEAM VM.

[Erlang](https://www.erlang.org/) es un lenguaje de programación funcional, concurrente y de tipado dinámico que se ejecuta sobre la máquina virtual **BEAM** (Bogdan/Björn's Erlang Abstract Machine). Fue desarrollado por Ericsson para sistemas de telecomunicaciones con requisitos de alta disponibilidad, concurrencia masiva y tolerancia a fallos.

---

## 📂 Estructura del repositorio

```text
erlang/
├── README.md              # Este archivo
├── LICENSE                # Licencia del proyecto
├── core/
│   └── foundations/       # Proyectos de fundamentos (Core Foundations)
│       ├── helloworld/    # 01_Hello_World
│       ├── hellouser/     # 02_Hello_User
│       ├── unit_test/
│       │   └── calculator/  # 03_Unit_Test_Calculator
│       └── numbers/       # 04_Numbers
```

---

## 🧠 Características del lenguaje

| Característica | Descripción |
|----------------|-------------|
| **Paradigma** | Funcional, con estado inmutable (single assignment) |
| **Concurrencia** | Modelo de actores: procesos ligeros con paso de mensajes |
| **Tipado** | Dinámico, fuerte |
| **Compilación** | `erlc` → bytecode BEAM (`.beam`) |
| **Tail Call Optimization** | ✅ **Garantizado por la BEAM VM** |
| **Testing** | EUnit (integrado en OTP) |
| **Build system** | `rebar3` (estándar) |
| **Filosofía** | "Let it crash" — supervisión y tolerancia a fallos |

---

## 🚀 Herramientas

| Herramienta | Propósito |
|-------------|-----------|
| `erlc` | Compilador de Erlang a bytecode BEAM |
| `erl` | Shell interactivo y ejecutor de la BEAM VM |
| `rebar3` | Sistema de compilación, gestión de dependencias y ejecución de tests |

```bash
# Verificar instalación
erl -version
rebar3 --version
```

---

## 📋 Proyectos implementados

| # | Proyecto | Enfoques | Testing |
|---|----------|----------|---------|
| [01](core/foundations/helloworld/) | Hello World | — | — |
| [02](core/foundations/hellouser/) | Hello User | — | — |
| [03](core/foundations/unit_test/calculator/) | Calculator | 5 operaciones aritméticas | EUnit (5 tests) |
| [04](core/foundations/numbers/) | Numbers | 5 algoritmos × 2 enfoques (rec, acc) | EUnit (10 tests) |

---

## 🌐 Más información

- [Sitio oficial de Erlang](https://www.erlang.org/)
- [Repositorio principal](https://github.com/yorche3/programming_languages)
- [GitHub Pages](https://yorche3.github.io/programming_languages/)

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*