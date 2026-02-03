# Notas del Dr. Miller

## Estructura
Los archivos principales son:
```txt
./
├── diferenciales.def
├── luamaster.tex
├── clase_1.tex
├── clase_2.tex
├── clase_3.tex
├── apendice_1.tex
├── apendice_2.tex
├── figures
│   ├── figura_2.svg
│   ├── figura_3.svg
│   └── figura_4.svg
├── lua
│   ├── figura_complicada_1.lua
│   ├── figura_complicada_2.lua
│   └── figura_complicada_3.lua
└── README.md
```
* `luamaster.tex` contiene el preámbulo, las primeras hojas, que no pertenecen
    a ningún capítulo, y algo como:
```tex
\begin{document}
    \input{clase_1}
    \input{clase_2}
    \appendix
    \input{apendice_1}
\end{document}
```

* En la carpeta `figures` van archivos `.svg`. Figuras más complicadas
    se pueden hacer con
    [luadraw](https://github.com/pfradin/luadraw/blob/main/doc/luadraw/luadraw-doc-en.pdf),
    y el código para generarlas va en la carpeta `lua`.

* En los archivos `.tex` no se incluirán directamente los
    archivos con extensión `.svg` ni los con extensión `.lua`.
    En vez de eso, habrán dos sub-carpetas:
    `figures/exports`, y `figures/_luadraw`.
    En `exports` habrán archivos `.pdf` y `.pdf_tex` por cada archivo `.svg`,
    y en `_luadraw` habrá un archivo `.tkz` por cada
    figura hecha para `luadraw`.
    Instrucciones para generar e incluir esos archivos abajo.

## Generar e incluir figuras.

### Inkscape para svg
Por ahora, para generar los archivos de las figuras `.svg`, abrir una terminal
en el directorio `figures`, y correr:
```bash
for f in *.svg; do inkscape "$f" --export-area-page --export-dpi 300 --export-type=pdf --export-latex --export-filename "./exports/${f::-4}.pdf"
```

Luego, para incluir la figura colocada en `figures/figura_1.svg`, se puede
incluir:
```tex
\begin{figure}[H]
    \begin{minipage}[c]{0.55\textwidth}
        \centering
        \incfig{figura_1}               %  <---- aquí el nombre del archivo
    \end{minipage}\hfill
    \begin{minipage}[c]{0.40\textwidth}
        \caption{
            Aquí se explica qué representa la figura, y se pueden incluir
            ecuaciones como $1+1=2$, o $\int_{x_1}^{x_2} \ds{x} = x_2 - x_1$
        }%
    \label{fig:esta_es_la_primera_fig}
    \end{minipage}
\end{figure}
```

O bien:
```tex
\begin{figure}[H]
    \centering
    \incfig{figura_1}                   %  <---- aquí el nombre del archivo
    \caption{
        Descripcion de la figura
    }%
    \label{fig:esta_es_la_primera_fig}
\end{figure}
```

### Luadraw para lua
Los archivos `.tkz` para las figuras hechas con `luadraw` se generan
por si mismos.

Para incluir la figura generada por `lua/figura_1.lua`, se pueden usar lo mismo
que lo mostrado en la sección anterior, pero sustituyendo la línea que dice
`\incfig{figura_1}`, por lo siguiente:
```tex
\begin{luadraw}{name=Algun_nombre_sin_espacios, exec=true}
    require "lua.figura_1" -- % chktex 18 chktex 8
\end{luadraw}
```

**Nota:** Mientras se está haciendo la figura, es necesario usar
`exec=true` en la tabla que aparece justo después de `\begin{luadraw}`.
Cuando la figura se considera terminada, o se va a trabajar en
otras partes del documento, es conveniente cambiar por `exec=false`,
para que `lualatex` use el archivo `.tkz` en vez de
ejecutar el código cada vez que se recompila.

## Algunos macros

### Diferenciales
Los diferenciales se escriben como `\ds{x}`, y para varias dimensiones se agrega
el superíndice al diferencial. Por ejemplo un diferencial de línea: `\ds{x}^2`.

**Nota:** Un diferencial de línea se escribe `\ds{x}^2`. Si pusiéramos
`\ds{x^2}`, tendríamos el diferencial de `x^2`.

### Vectores
Vectores en negrita y con flecha se ponen como `\vect{E}`. Si hay
{sub,super}índices,
ponerlos fuera de `\vect`. Por ejemplo, `\vect{E}_0` o `\vect{x}'`.

Vectores unitarios se ponen de la misma manera, pero con `\hatvect`. Por ejemplo
`\hatvect{i}` o `\hatvect{e}_x`.

La norma de un vector se puede poner con `\norma`. Por ejemplo:
`\norma{ \vect{x} - \vect{x}' }.`

## Anotaciones
(TODO)

## Guía de estilo
(TODO)

* Evito usar colores porque imprimir a color es caro.

* Trato de no pasarme de 80 caracteres por línea. Es mejor ir hacia abajo
    (muchas líneas cortas) que a la derecha (pocas líneas, pero muy largas).

* Para ecuaciones, me gusta usar indentaciones completas (4 espacios)
    para distinguir factores, y medias indentaciones (2 espacios) para
    distinguir sumandos. También me gusta partir líneas en signos de
    suma y resta.
