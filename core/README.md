# Erlang Core

> **Proyectos centrales de Erlang** — Implementaciones organizadas por nivel de dificultad.

Este directorio agrupa los proyectos implementados en **Erlang/OTP**, organizados según el temario del [repositorio principal](https://github.com/yorche3/programming_languages).

---

## 📂 Estructura

```text
erlang/core/
├── README.md              # Este archivo
└── foundations/           # Proyectos de fundamentos
    ├── helloworld/        # 01_Hello_World
    ├── hellouser/         # 02_Hello_User
    ├── unit_test/
    │   └── calculator/    # 03_Unit_Test_Calculator
    └── numbers/           # 04_Numbers
```

---

## 📋 Proyectos

| # | Proyecto | Descripción | Herramientas |
|---|----------|-------------|--------------|
| [01](foundations/helloworld/) | Hello World | Imprimir un saludo en consola | `erlc`, `erl` |
| [02](foundations/hellouser/) | Hello User | Leer nombre y saludar personalizadamente | `erlc`, `erl` |
| [03](foundations/unit_test/calculator/) | Calculator | 5 operaciones con pruebas unitarias | `rebar3`, EUnit |
| [04](foundations/numbers/) | Numbers | Algoritmos matemáticos (rec y acc) | `rebar3`, EUnit |

---

## 🛠️ Herramientas utilizadas

| Herramienta | Uso |
|-------------|-----|
| **`erlc`** | Compilación de archivos `.erl` a `.beam` |
| **`erl`** | Ejecución en la BEAM VM |
| **`rebar3`** | Sistema de compilación para proyectos con tests |
| **EUnit** | Framework de testing integrado en OTP |

---

## 🌐 Enlaces

- [Fundamentos →](foundations/)
- [Repositorio principal](https://github.com/yorche3/programming_languages)
- [GitHub Pages](https://yorche3.github.io/programming_languages/)

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
