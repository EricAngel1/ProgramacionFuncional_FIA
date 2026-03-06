%Miembros del Equipo 7
%Angel Alexis Serrano Hernández - 219906183
%Eric Eduardo Angel Angel - 223992884
%Carlos González Rodríguez - 220886978
%Lizeth Gutiérrez Torres - 220616369
%Cristhian German  Ramírez  Ruiz - 223992922

menu:- nl,
write("1. Buscar"),nl,
write("2. Comprobar/Listar"),nl,
write("3. Concatenar"),nl,
write("4. Agregar"),nl, 
write("5. Eliminar"),nl,          
write("6. Longitud"),nl,
write("7. Ordenamiento"),nl.
    read(Opcion),
    ejecutar(Opcion).

% Placeholders para que pongan sus propias implementaciones
% ejecutar(1):- ...
% ejecutar(2):- ...
% ejecutar(3):- ...
ejecutar(4) :- write("Ingrese el nombre de la lista: "), read(ListaName),
               write("Ingrese el elemento a agregar: "), read(Elemento),
               agregar(Elemento, ListaName).
ejecutar(5) :- write("Ingrese el nombre de la lista: "), read(ListaName),
               write("Ingrese el elemento a eliminar: "), read(Elemento),
               eliminar(Elemento, ListaName).
% ejecutar(6):- ...
% ejecutar(7):- ...

concatenar([],L2,L2).
concatenar([H|T],L2,[H|L3]):- concatenar(T,L2,L3).

agregar(Elemento, ListaName) :-
    TermConsulta =.. [ListaName, Lista],
    call(TermConsulta),
    \+ member(Elemento, Lista),
    retract(TermConsulta),
    append(Lista, [Elemento], NuevaLista),
    TermNuevo =.. [ListaName, NuevaLista],
    assertz(TermNuevo),
    guardar_base,
    write("Elemento agregado exitosamente.").

eliminar(Elemento, ListaName) :-
    TermConsulta =.. [ListaName, Lista],
    call(TermConsulta),
    member(Elemento, Lista),
    retract(TermConsulta),
    delete(Lista, Elemento, NuevaLista),
    TermNuevo =.. [ListaName, NuevaLista],
    assertz(TermNuevo),
    guardar_base,
    write("Elemento eliminado exitosamente.").

guardar_base :-
    tell('baseconocimiento.pl'),
    write(':- dynamic robothw/1.'), nl,
    write(':- dynamic robotsw/1.'), nl,
    write(':- dynamic versiones/1.'), nl,
    write(':- dynamic evapreoperacion/1.'), nl,
    write(':- dynamic modulointeligente/1.'), nl,
    write(':- dynamic operacion/1.'), nl, nl,

    robothw(L1), write('robothw('), write(L1), write(').'), nl,
    robotsw(L2), write('robotsw('), write(L2), write(').'), nl,
    versiones(L3), write('versiones('), write(L3), write(').'), nl,
    evapreoperacion(L4), write('evapreoperacion('), write(L4), write(').'), nl,
    modulointeligente(L5), write('modulointeligente('), write(L5), write(').'), nl,
    operacion(L6), write('operacion('), write(L6), write(').'), nl,

    told.

longitud([],0).

longitud([_|T], N) :- longitud(T, N1), N is N1 + 1.
