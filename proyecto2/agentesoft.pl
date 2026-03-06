%Miembros del Equipo 7
%Angel Alexis Serrano Hernández - 219906183
%Eric Eduardo Angel Angel - 223992884
%Carlos González Rodríguez - 220886978
%Lizeth Gutiérrez Torres - 220616369
%Cristhian German  Ramírez  Ruiz - 223992922

:- consult('baseconocimiento.pl').

menu:- nl,
write("1. Buscar"),nl,
write("2. Comprobar/Listar"),nl,
write("3. Concatenar"),nl,
write("4. Agregar"),nl, 
write("5. Eliminar"),nl,          
write("6. Longitud"),nl,
write("7. Ordenamiento"),nl,
    read(Opcion),
    ejecutar(Opcion).

% Placeholders para que pongan sus propias implementaciones
ejecutar(1):- 
    write("Ingrese el nombre de la lista a buscar --> (robotsw): "), read(NombredeLista),
    write("Ingrese el elemento de la lista a buscar --> (funcionalidad_avanzada): "), read(NombredeElemento),
    buscar(NombredeLista,NombredeElemento).
ejecutar(2):- 
    write("Ingrese el nombre de la lista que quiera comprobar ===> (robotsw): "), read(NombredeLista),
    (   Comprobar=.. [NombredeLista,Lista]
    -> call(Comprobar),
        write("Segun mis fuentes, los elementos de la lista "), write(NombredeLista), write(" son: "), nl,
        comprobarListilla(Lista)
    ).
ejecutar(3) :- 
               write("Ingrese el nombre de la primera lista: "), read(Lista1),
               write("Ingrese el nombre de le segunda lista: "), read(Lista2),
               Term1 =.. [Lista1, ListaA], call(Term1),
               Term2 =.. [Lista2, ListaB], call(Term2),
               concatenar(ListaA, ListaB, Resultado),
               write("Unión: "), nl,
               write(Resultado).
ejecutar(4) :- write("Ingrese el nombre de la lista: "), read(ListaName),
               write("Ingrese el elemento a agregar: "), read(Elemento),
               agregar(Elemento, ListaName).
ejecutar(5) :- write("Ingrese el nombre de la lista: "), read(ListaName),
               write("Ingrese el elemento a eliminar: "), read(Elemento),
               eliminar(Elemento, ListaName).
ejecutar(6) :- write("Ingrese el nombre de la lista a analizar: "), read(Nombre),
               Term =.. [Nombre, Lista],
               (    call(Term)
               ->   longitud(Lista, N),
                    write("La longitud de "), write(Nombre), write(" es: "), write(N)
                ;   write("Lista no encontrada...")).        
ejecutar(7) :-
    write("Ingrese el nombre de la lista: "), read(ListaName),
        organizar(ListaName, Ordenada),
        write("Lista ordenada: "), write(Ordenada).


%#######################################################################
%Pongo el metodo de buscar
buscar(NombredeLista,NombredeElemento) :-
    (   Busqueda=.. [NombredeLista,Lista],
        call(Busqueda)
    ->  (member(NombredeElemento,Lista)
        ->  write("Si esta")
        ;   write("No esta en la lista querido amigo. ¿Desea agregar ese elemento a la lista Actual? (s/n)"),
            read(Respuesta),
            ( (Respuesta == 's')
            -> agregar(NombredeElemento, NombredeLista)
            ;  write("Perfecto patron, lo dejamos asi amigo...")
            )
        )
    ).

%#######################################################################
%Pongo el metodo de buscar



%Aqui mas que nada comprueba si esta vacia pues termina
comprobarListilla([]).

%Aqui aplicamos el caso recursivo, agarra la cabeza primero y ya luego imprime la cola
comprobarListilla([H|T]) :-
    write("--- "), write(H), nl,
    comprobarListilla(T).





%#######################################################################
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

organizar(ListaName, Ordenada) :-
    Term =.. [ListaName, Lista],
    call(Term),
    sort(Lista, Ordenada).

