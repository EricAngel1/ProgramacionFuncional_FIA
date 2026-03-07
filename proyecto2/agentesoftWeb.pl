%Miembros del Equipo 7
%Angel Alexis Serrano Hernández - 219906183
%Eric Eduardo Angel Angel - 223992884
%Carlos González Rodríguez - 220886978
%Lizeth Gutiérrez Torres - 220616369
%Cristhian German  Ramírez  Ruiz - 223992922

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_files)).

:- consult('baseconocimiento.pl').
:- consult('agentesoft.pl').

% RUTAS
:- http_handler(root(.), http_reply_file('index.html', []), []).
:- http_handler(root('fondo.png'), http_reply_file('fondo.png', []), []).
:- http_handler(root('udg.png'), http_reply_file('udg.png', []), []).
:- http_handler(root(buscar), buscarWeb, []).
:- http_handler(root(confirmar_agregar), agregarWeb, []).
:- http_handler(root(listar), listarWeb, []).
:- http_handler(root(agregar_ejecutar), agregarEjecuWeb, []).
:- http_handler(root(eliminar_ejecutar), eliminarEjecuWeb, []).
:- http_handler(root(ordenar), ordenarWeb, []).
:- http_handler(root(concatenar), concatenarWeb, []).
:- http_handler(root(longitud), longitudWeb, []).

servidor(Puerto) :-
    http_server(http_dispatch, [port(Puerto)]),
    format('Servidor en: http://localhost:~w~n', [Puerto]).


%#############################################################################
% Lógica de Búsqueda y Pregunta en Interfaz
buscarWeb(Request) :-
    http_parameters(Request, [
        lista(NombreStr, []),
        elemento(ElemStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    atom_string(Elemento, ElemStr),
    
    format('Content-type: text/html; charset=UTF-8~n~n', []),
    (   lista(Nombre, ListaReal)
    ->  (member(Elemento, ListaReal)
        -> format('<h1>Resultado: SI EXISTE</h1><a href="/">Volver</a>', [])
        ;   
            format('<h1>Resultado: NO EXISTE</h1>', []),
            format('<p>¿Deseas agregar "<b>~w</b>" a la lista "<b>~w</b>"?</p>', [Elemento, Nombre]),
            format('<form action="/confirmar_agregar" method="GET">
                      <input type="hidden" name="lista" value="~w">
                      <input type="hidden" name="elemento" value="~w">
                      <button type="submit" style="background:green; color:white;">Si, agregar ahora</button>
                      <a href="/"><button type="button">No, volver</button></a>
                    </form>', [Nombre, Elemento])
        )
    ;   format('<h1>Error: La lista ~w no existe</h1><a href="/">Volver</a>', [Nombre])
    ).

% Lógica para ejecutar el agregado real
agregarWeb(Request) :-
    http_parameters(Request, [
        lista(NombreStr, []),
        elemento(ElemStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    atom_string(Elemento, ElemStr),
    (   agregar(Elemento, Nombre)
    ->  format('Content-type: text/html; charset=UTF-8~n~n', []),
        format('<h1>Ya está</h1><p>Se ha agregado "~w" a ~w.</p><a href="/">Volver al inicio</a>', [Elemento, Nombre])
    ;   format('Content-type: text/html; charset=UTF-8~n~n', []),
        format('<h1>Error</h1><p>No se pudo guardar.</p><a href="/">Volver</a>', [])
    ).

% La lógica para listar las listas
listarWeb(Request) :-
    http_parameters(Request, [
        lista(NombreStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    
    format('Content-type: text/html; charset=UTF-8~n~n', []),
    format('<html><body>', []),
    (   lista(Nombre, ListaReal)
    ->  format('<h1>Elementos de la lista: ~w</h1>', [Nombre]),
        format('<ul>', []),
        listar_web(ListaReal),
        format('</ul>', [])
    ;   format('<h1>Error: La lista ~w no existe</h1>', [Nombre])
    ),
    format('<br><a href="/">Volver al inicio</a></body></html>', []).

listar_web([]).
listar_web([H|T]) :-
    format('<li>~w</li>', [H]),
    listar_web(T).

%#############################################################################
% logica de agregar
agregarEjecuWeb(Request) :-
    http_parameters(Request, [
        lista(NombreStr, []),
        elemento(ElemStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    atom_string(Elemento, ElemStr),
    (   agregar(Elemento, Nombre)
    ->  format('Content-type: text/html; charset=UTF-8~n~n', []),
        format('<h1>Ya está</h1><p>Se ha agregado "~w" a ~w.</p><a href="/">Volver al inicio</a>', [Elemento, Nombre])
    ;   format('Content-type: text/html; charset=UTF-8~n~n', []),
        format('<h1>Error</h1><p>No se pudo guardar.</p><a href="/">Volver</a>', [])
    ).

% logica de eliminar
eliminarEjecuWeb(Request) :-
    http_parameters(Request, [
        lista(NombreStr, []),
        elemento(ElemStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    atom_string(Elemento, ElemStr),
    format('Content-type: text/html; charset=UTF-8~n~n', []),
    (   eliminar(Elemento, Nombre)
    ->  format('<html><body>
                  <h2>🗑️ Elemento eliminado</h2>
                  <p>"~w" fue eliminado de la lista <b>~w</b>.</p>
                  <a href="/">Volver al inicio</a>
               </body></html>', [Elemento, Nombre])
    ;   format('<html><body>
                  <h2>⚠️ No se pudo eliminar</h2>
                  <p>El elemento "~w" no existe en la lista <b>~w</b> o la lista no existe.</p>
                  <a href="/">Volver al inicio</a>
               </body></html>', [Elemento, Nombre])
    ).

%#############################################################################
% logica de ordenar una lista
ordenarWeb(Request) :-
    http_parameters(Request, [
        lista(NombreStr, [])
    ]),
    atom_string(Nombre, NombreStr),

    format('Content-type: text/html; charset=UTF-8~n~n', []),
    format('<html><body>', []),

    (   organizar(Nombre, Ordenada)
    ->  format('<h1>Lista ordenada (~w):</h1>', [Nombre]),
        format('<p>~w</p>', [Ordenada])
    ;   format('<h1>Error: La lista ~w no existe</h1>', [Nombre])
    ),

    format('<br><a href="/">Volver al inicio</a>', []),
    format('</body></html>', []).

%#############################################################################
% logica de de concatenar dos listas
concatenarWeb(Request) :-
    http_parameters(Request, [
        lista1(NombreStr1, []),
        lista2(NombreStr2, [])
    ]),
    atom_string(Nombre1, NombreStr1),
    atom_string(Nombre2, NombreStr2),

    format('Content-type: text/html; charset=UTF-8~n~n', []),
    format('<html><body>', []),

    (   concatenar(Nombre1, Nombre2, Resultado)
    ->  format('<h1>Resultado de la Concatenación</h1>', []),
        format('<h3>Unión resultante:</h3><p>~w</p>', [Resultado])
    ;   format('<h1>Error</h1><p>Una o ambas listas no existen en la base de conocimiento.</p>', [])
    ),
    format('<br><a href="/">Volver al inicio</a></body></html>', []).

%#############################################################################
% logica de calcular la longitud de una lista
longitudWeb(Request) :-
    http_parameters(Request, [
        lista(NombreStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    
    format('Content-type: text/html; charset=UTF-8~n~n', []),
    format('<html><body>', []),

    (   longitud(Nombre, N)
    ->  format('<h1>Longitud de la lista ~w</h1>', [Nombre]),
        format('<h3>Total de elementos: ~w</h3>', [N])
    ;   format('<h1>Error</h1><p>La lista <b>~w</b> no existe.</p>', [Nombre])
    ),
    format('<br><a href="/">Volver al inicio</a></body></html>', []).

%#############################################################################
%Se acabo...