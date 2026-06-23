# Calculator — Erlang

> **Core Foundations · 03_Unit_Test_Calculator · Erlang**

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Erlang**, usando **EUnit** como framework de pruebas unitarias y **rebar3** como sistema de compilación.

Implementa las 5 operaciones aritméticas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) usando únicamente `+` y `-` como operaciones primitivas directas, con fines educativos.

---

## 📂 Archivos

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`rebar.config`](rebar.config) | Configuración de rebar3 (compilación, dependencias) |
| [`src/calculator.app.src`](src/calculator.app.src) | Archivo de aplicación OTP (metadatos del proyecto) |
| [`src/calculator.erl`](src/calculator.erl) | Implementación de las 5 operaciones aritméticas |
| [`test/calculator_test.erl`](test/calculator_test.erl) | 5 pruebas unitarias con EUnit |

**Estructura esperada:**

```text
calculator/
├── rebar.config                   # Configuración de rebar3
├── src/
│   ├── calculator.app.src         # Metadatos de la aplicación OTP
│   └── calculator.erl             # 5 operaciones aritméticas
├── test/
│   └── calculator_test.erl        # 5 tests con EUnit
├── _build/                        # Compilados (generado por rebar3)
└── README.md                      # Este archivo
```

---

## 💻 Código

### `src/calculator.erl` — Implementación

```erlang
-module(calculator).

-export([addition/2, subtraction/2, multiplication/2, division/2, modulus/2]).

addition(A, B) -> A + B.

subtraction(A, B) -> A - B.

multiplication(A, B) ->
    multiplication(A, B, A).

multiplication(_, B, _) when B =< 0 -> 0;
multiplication(_, 1, Acc) -> Acc;
multiplication(A, B, Acc) -> multiplication(A, subtraction(B, 1), addition(Acc, A)).

division(A, B) ->
    division(A, B, 0).

division(A, B, Quotient) when A < B -> Quotient;
division(A, B, Quotient) -> division(subtraction(A, B), B, addition(Quotient, 1)).

modulus(A, B) ->
    Quotient = division(A, B),
    Product = multiplication(B, Quotient),
    subtraction(A, Product).
```

### `test/calculator_test.erl` — Pruebas unitarias

```erlang
-module(calculator_test).
-include_lib("eunit/include/eunit.hrl").

addition_test() ->
    ?assertEqual(calculator:addition(2, 3), 5).

subtraction_test() ->
    ?assertEqual(calculator:subtraction(5, 2), 3).

multiplication_test() ->
    ?assertEqual(calculator:multiplication(4, 3), 12).

division_test() ->
    ?assertEqual(calculator:division(10, 3), 3).

modulus_test() ->
    ?assertEqual(calculator:modulus(10, 3), 1).
```

---

## 🛠️ Enfoque e implementación

### Cláusulas múltiples con guardas

En lugar de funciones helper separadas, Erlang usa **múltiples cláusulas** de la misma función separadas por `;` con **guardas** (`when`):

```erlang
multiplication(_, B, _) when B =< 0 -> 0;   % Caso base: B <= 0
multiplication(_, 1, Acc) -> Acc;            % Caso base: B == 1
multiplication(A, B, Acc) -> ...             % Caso recursivo
```

Las cláusulas se evalúan en orden; la primera que matchea se ejecuta.

### Sobrecarga por aridad

Erlang distingue funciones por **nombre + aridad**:
- `multiplication/2` — interfaz pública (`A * B`)
- `multiplication/3` — función recursiva interna (con acumulador)

La función pública delega en la privada con el acumulador inicializado.

### Operaciones implementadas

| Operación | Implementación | Primitivas usadas |
|-----------|---------------|-------------------|
| `addition(A, B)` | `A + B` | `+` |
| `subtraction(A, B)` | `A - B` | `-` |
| `multiplication(A, B)` | Suma repetitiva de `A`, `B` veces con recursión | `+`, `-` |
| `division(A, B)` | Resta repetitiva de `B` de `A`, cuenta cociente | `+`, `-` |
| `modulus(A, B)` | `A - (cociente * B)` | `+`, `-` |

---

## 🚀 Compilación y ejecución

### Requisito: Tener rebar3 y Erlang/OTP instalados

```bash
# Verificar instalación
rebar3 --version
erl -version
```

### Compilar

```bash
cd erlang/core/foundations/unit_test/calculator
rebar3 compile
```

### Ejecutar tests unitarios

```bash
rebar3 eunit
```

**Salida esperada:**

```text
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling calculator
===> Performing EUnit tests...
.....
Finished in 0.00 seconds
5 tests, 0 failures
```

---

## 📝 Notas de implementación

- **Cláusulas contiguas**: Todas las cláusulas de una misma función deben definirse **juntas y contiguas** en el código. No puedes intercalar cláusulas de otra función entre ellas.
- **`;` vs `.`**: Las cláusulas de una misma función se separan con `;`. El `.` finaliza la definición completa de la función.
- **Guardas**: Usan `when` para condiciones adicionales que no pueden expresarse solo con pattern matching (ej: `B =< 0`, `A < B`).
- **Aridad**: `multiplication/2` y `multiplication/3` son funciones **distintas** para Erlang. La primera es la interfaz pública; la segunda es la helper recursiva.
- **Inmutabilidad**: No hay variables mutables. El "estado" se pasa como parámetros adicionales en la recursión (el acumulador `Acc` o el `Quotient`).
- **EUnit**: El framework de tests integrado en Erlang/OTP. Las funciones de test deben terminar en `_test()`.
- **`include_lib`**: `-include_lib("eunit/include/eunit.hrl")` importa las macros como `?assertEqual`.

---

## 🧠 Conceptos de Erlang demostrados

| Concepto | Descripción |
|----------|-------------|
| Módulos | `-module(name).` define un módulo |
| Exportación | `-export([fun/arity]).` hace visible una función |
| Múltiples cláusulas | Separadas por `;` con pattern matching y guardas |
| Guardas (`when`) | Condiciones extra en cláusulas: `when B =< 0` |
| Pattern matching | Las cláusulas se matchean en orden con `_` para ignorar |
| Recursión de cola | `multiplication/3` y `division/3` son tail-recursive |
| Aridad | `multiplication/2` y `multiplication/3` son funciones distintas |
| `io:fwrite` | Formateo con `~s`, `~p`, etc. |
| EUnit | Framework de tests con `?assertEqual`, `?assert` |
| `rebar3` | Sistema de compilación y gestión de dependencias |

---

### 🌐 Otras implementaciones

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
