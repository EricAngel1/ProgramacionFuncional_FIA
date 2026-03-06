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

% RUTAS
:- http_handler(root(.), http_reply_file('index.html', []), []).
:- http_handler(root(buscar), handle_buscar_simple, []).
:- http_handler(root(confirmar_agregar), handle_confirmar_agregar, []).
:- http_handler(root(listar), handle_listar, []).

servidor(Puerto) :-
    http_server(http_dispatch, [port(Puerto)]),
    format('Servidor en: http://localhost:~w~n', [Puerto]).

% Lógica de Búsqueda y Pregunta en Interfaz
handle_buscar_simple(Request) :-
    http_parameters(Request, [
        lista(NombreStr, []),
        elemento(ElemStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    atom_string(Elemento, ElemStr),
    
    Termino =.. [Nombre, ListaReal],
    format('Content-type: text/html; charset=UTF-8~n~n', []),
    (   current_predicate(Nombre/1), call(Termino)
    ->  (member(Elemento, ListaReal)
        -> format('<h1>Resultado: SI EXISTE</h1><a href="/">Volver</a>', [])
        ;  % SI NO EXISTE: Mostramos la pregunta y un botón para agregar
           format('<h1>Resultado: NO EXISTE</h1>', []),
           format('<p>¿Deseas agregar "<b>~w</b>" a la lista "<b>~w</b>"?</p>', [Elemento, Nombre]),
           format('<form action="/confirmar_agregar" method="GET">
                     <input type="hidden" name="lista" value="~w">
                     <input type="hidden" name="elemento" value="~w">
                     <button type="submit" style="background:green; color:white;">Sí, agregar ahora</button>
                     <a href="/"><button type="button">No, volver</button></a>
                   </form>', [Nombre, Elemento])
        )
    ;   format('<h1>Error: La lista ~w no existe</h1><a href="/">Volver</a>', [Nombre])
    ).

% Lógica para ejecutar el agregado real
handle_confirmar_agregar(Request) :-
    http_parameters(Request, [
        lista(NombreStr, []),
        elemento(ElemStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    atom_string(Elemento, ElemStr),
    (   agregar(Elemento, Nombre)
    ->  format('Content-type: text/html; charset=UTF-8~n~n', []),
        format('<h1>¡Listo!</h1><p>Se ha agregado "~w" a ~w.</p><a href="/">Volver al inicio</a>', [Elemento, Nombre])
    ;   format('Content-type: text/html; charset=UTF-8~n~n', []),
        format('<h1>Error</h1><p>No se pudo guardar.</p><a href="/">Volver</a>', [])
    ).

handle_listar(Request) :-
    http_parameters(Request, [
        lista(NombreStr, [])
    ]),
    atom_string(Nombre, NombreStr),
    
    Termino =.. [Nombre, ListaReal],
    format('Content-type: text/html; charset=UTF-8~n~n', []),
    format('<html><body>', []),
    (   current_predicate(Nombre/1), call(Termino)
    ->  format('<h1>Elementos de la lista: ~w</h1>', [Nombre]),
        format('<ul>', []),
        % Llamamos a nuestra versión web de comprobarListilla
        listar_web(ListaReal),
        format('</ul>', [])
    ;   format('<h1>Error: La lista ~w no existe</h1>', [Nombre])
    ),
    format('<br><a href="/">Volver al inicio</a></body></html>', []).
% Tu lógica de comprobarListilla adaptada a HTML
listar_web([]).
listar_web([H|T]) :-
    % En lugar de write("--- "), usamos etiquetas de lista HTML <li>
    format('<li>~w</li>', [H]),
    listar_web(T).