# Hello, World! — Erlang

> **Core Foundations · 01_Hello_World · Erlang**

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Erlang**, compilado con **erlc** y ejecutado con **erl**.

---

## 📂 Archivos

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.erl`](hello_world.erl) | Código fuente: módulo `hello_world` con función `main/0` |
| `hello_world.beam` | Archivo compilado (bytecode BEAM, generado por `erlc`) |

**Estructura esperada:**

```text
helloworld/
├── hello_world.erl          # Código fuente
├── hello_world.beam         # Compilado (generado)
└── README.md                # Este archivo
```

---

## 💻 Código

```erlang
-module(hello_world).
-export([main/0]).

main() ->
  io:fwrite("Hello world! from Erlang\n").
```

| Elemento | Descripción |
|----------|-------------|
| `-module(hello_world).` | Declara el nombre del módulo (debe coincidir con el nombre del archivo `.erl`) |
| `-export([main/0]).` | Exporta la función `main` con aridad 0 (pública) |
| `main() -> ...` | Define la función `main` usando la sintaxis de cláusulas `->` |
| `io:fwrite(...)` | Función de E/S del módulo `io` para escribir formateado a la salida estándar |
| `\n` | Salto de línea (como en C) |

---

## 🚀 Compilación y ejecución

### Requisito: Tener Erlang/OTP instalado

```bash
# Verificar instalación
erl -version
```

### Compilar

```bash
cd erlang/core/foundations/helloworld
erlc hello_world.erl
```

Esto genera `hello_world.beam` (bytecode para la máquina virtual BEAM).

### Ejecutar

```bash
# Opción 1: Usar erl con -run (ejecuta y sale)
erl -noshell -s hello_world main -s init stop

# Opción 2: Entrar al shell y llamar manualmente
erl
1> c(hello_world).
{ok,hello_world}
2> hello_world:main().
Hello world! from Erlang
ok
3> q().
```

**Salida esperada:**

```text
Hello world! from Erlang
```

---

## 📝 Notas de implementación

- **Compilación**: `erlc` genera archivos `.beam` que contienen bytecode para la máquina virtual BEAM.
- **Convención de nombres**: El nombre del módulo (declarado con `-module(...)`) debe coincidir exactamente con el nombre del archivo `.erl`.
- **Exportación**: Las funciones deben exportarse explícitamente con `-export([...])` para ser visibles desde fuera del módulo.
- **`-noshell`**: Inicia Erlang sin shell interactivo.
- **`-s hello_world main`**: Llama a la función `hello_world:main/0` al arrancar.
- **`-s init stop`**: Detiene el sistema Erlang después de ejecutar la función.
- **Aridad**: En Erlang, las funciones se identifican por nombre **y** aridad (número de parámetros). `main/0` significa `main` con 0 parámetros.

---

## 🧠 Conceptos de Erlang demostrados

| Concepto | Descripción |
|----------|-------------|
| Módulos | `-module(name).` define un módulo |
| Exportación | `-export([fun/arity]).` hace visible una función |
| Pattern matching | Base del lenguaje (aunque no se usa explícitamente aquí) |
| Funciones | Definidas con `nombre(Args) -> Cuerpo.` |
| `io:fwrite/1` | E/S formateada a stdout |
| Compilación | `erlc` compila `.erl` → `.beam` |
| BEAM VM | Máquina virtual donde corre Erlang |

---

### 🌐 Otras implementaciones

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
