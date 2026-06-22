# Hello, User! — Erlang

> **Core Foundations · 02_Hello_User · Erlang**

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Erlang**, compilado con **erlc** y ejecutado con **erl**.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos

| Archivo | Propósito |
|---------|-----------|
| [`hello_user.erl`](hello_user.erl) | Código fuente: módulo `hello_user` con función `main/0` |
| `hello_user.beam` | Archivo compilado (bytecode BEAM, generado por `erlc`) |

**Estructura esperada:**

```text
hellouser/
├── hello_user.erl           # Código fuente
├── hello_user.beam          # Compilado (generado)
└── README.md                # Este archivo
```

---

## 💻 Código

```erlang
-module(hello_user).
-export([main/0]).

main() ->
   Name = io:get_line("Enter your name: "),
   io:fwrite("Hello, ~s", [Name]).
```

| Elemento | Descripción |
|----------|-------------|
| `-module(hello_user).` | Declara el nombre del módulo (debe coincidir con el nombre del archivo `.erl`) |
| `-export([main/0]).` | Exporta la función `main` con aridad 0 (pública) |
| `io:get_line(Prompt)` | Lee una línea completa desde la entrada estándar, mostrando el `Prompt` |
| `io:fwrite(Format, Args)` | Escribe texto formateado usando `~s` para insertar strings (similar a `%s` en C) |
| `~s` | Placeholder para string en la cadena de formato de `io:fwrite` |

---

## 🚀 Compilación y ejecución

### Requisito: Tener Erlang/OTP instalado

```bash
# Verificar instalación
erl -version
```

### Compilar

```bash
cd erlang/core/foundations/hellouser
erlc hello_user.erl
```

Esto genera `hello_user.beam` (bytecode para la máquina virtual BEAM).

### Ejecutar

```bash
# Opción 1: Usar erl con -run (ejecuta y sale)
erl -noshell -s hello_user main -s init stop

# Opción 2: Entrar al shell y llamar manualmente
erl
1> c(hello_user).
{ok,hello_user}
2> hello_user:main().
Enter your name: Ada
Hello, Ada!
ok
3> q().
```

**Salida esperada:**

```text
Enter your name: Ada
Hello, Ada!
```

---

## 📝 Notas de implementación

- **`io:get_line/1`**: Lee una línea completa incluyendo el salto de línea (`\n`). Por eso el saludo muestra `Hello, Ada!\n` — el `\n` capturado del input se intercala naturalmente.
- **`io:fwrite/2`**: Usa formato con `~s` para strings. Es el equivalente de `printf` en C, pero con la sintaxis de Erlang (`~` en lugar de `%`).
- **`-noshell`**: Inicia Erlang sin shell interactivo, útil para scripts.
- **`-s hello_user main`**: Ejecuta la función `hello_user:main/0` al arrancar.
- **`-s init stop`**: Detiene el sistema Erlang después de ejecutar la función. Sin esto, el shell quedaría esperando.
- **Asignación inmutable**: `Name = io:get_line(...)` usa pattern matching para asignar el valor. En Erlang, las variables solo se asignan una vez (inmutables).
- **Convención**: Los nombres de variables comienzan con mayúscula (`Name`). Los átomos (como nombres de funciones y módulos) comienzan con minúscula.

---

## 🧠 Conceptos de Erlang demostrados

| Concepto | Descripción |
|----------|-------------|
| Módulos | `-module(name).` define un módulo |
| Exportación | `-export([fun/arity]).` hace visible una función |
| `io:get_line/1` | Lectura de una línea desde stdin con prompt |
| `io:fwrite/2` | Escritura formateada con `~s`, `~p`, etc. |
| Asignación inmutable | `Name = ...` asigna una vez (single assignment) |
| Compilación | `erlc` compila `.erl` → `.beam` |
| BEAM VM | Máquina virtual donde corre Erlang |
| Pattern matching | La `=` es un operador de match, no asignación (aunque aquí funciona como asignación por ser una variable sin binding previo) |

---

### 🌐 Otras implementaciones

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
