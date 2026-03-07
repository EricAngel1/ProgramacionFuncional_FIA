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

ejecutar(1) :- 

        write("Ingrese el nombre de la lista: "), read(NombreLista),
        write("Ingrese el elemento a buscar: "), read(Elemento),
        (   busqueda(Elemento, NombreLista)
        ->  write("Si esta"), nl
        ;   % un if si no esta
            write("No se encuentra en la lista."), nl,
            write("¿Deseas agregar '"), write(Elemento), 
            write(" a la lista "), write(NombreLista), write("? (s/n): "),
            read(Respuesta),
            (   Respuesta == s
            ->  ( agregar(Elemento, NombreLista) 
                -> write("Elemento agregado con exito."), nl
                ;  write("Error: No se pudo agregar (¿existe la lista?)."), nl
                )
            ;   write("Perfecto lo dejamos asi"), nl
            )
        ).


ejecutar(2) :- 
    write("Ingrese el nombre de la lista: "), read(NombreLista),
    (   lista(NombreLista, Info)
    ->  write("Elementos de "), write(NombreLista), write(":"), nl,
        comprobar(Info)
    ;   write("Error: La lista no existe."), nl
    ).


ejecutar(3) :- 
    write("Ingrese nombre de la lista 1: "), read(Lista1),
    write("Ingrese nombre de la lista 2: "), read(Lista2),
    (   concatenar(Lista1, Lista2, Resultado)
    ->  write("Resultado de la union: "), write(Resultado), nl
    ;   write("Error: Una o ambas listas no existen."), nl
    ).


ejecutar(4) :- 
    write("Nombre de la lista: "), read(NombreLista),
    write("Elemento a agregar: "), read(Elemento),
    (   agregar(Elemento, NombreLista)
    ->  write("Agregado correctamente a "), write(NombreLista), nl
    ;   write("Error: No se pudo agregar (¿Existe la lista?)."), nl
    ).


ejecutar(5) :- 
    write("Nombre de la lista: "), read(NombreLista),
    write("Elemento a eliminar: "), read(Elemento),
    (   eliminar(Elemento, NombreLista)
    ->  write("Eliminado con exito."), nl
    ;   write("Error: El elemento no está o la lista no existe."), nl
    ).


ejecutar(6) :- 
    write("Ingrese el nombre de la lista a analizar: "), read(Nombre),
    (   longitud(Nombre, Resultado)
    ->  write("El numero de elementos es: "), write(Resultado), nl
    ;   write("Error: La lista no existe."), nl
    ).


ejecutar(7) :- 
    write("Ingrese el nombre de la lista: "), read(NombreLista),
    (   organizar(NombreLista, Resultado)
    ->  write("Lista ordenada: "), write(Resultado), nl
    ;   write("Error: La lista no existe."), nl
    ).


%#######################################################################
%Pongo el metodo de buscar
busqueda(E,NL) :- lista(NL, Lt),buscar(E, Lt). 
buscar(E,[E|_]).
buscar(E,[_|T]) :- buscar(E,T).
%#######################################################################
% logica de comprobar la lista
comprobar([]).
comprobar([H|T]) :- 
  write('-'), write(H), nl,
  comprobar(T).
%#######################################################################
% logica de concatenar
concatenar(L1, L2, R) :- lista(L1, Lt1), lista(L2, Lt2),append(Lt1, Lt2, R).
%#######################################################################
% logica de agregar
agregar(E, NL) :- retract(lista(NL, Lt)), append([E], Lt, Lr),assertz(lista(NL, Lr)), guardar_base.
%#######################################################################
% logica de eliminar
eliminar(E, NL) :- retract(lista(NL, Lt)), delete(Lt, E, Lr),assertz(lista(NL, Lr)),guardar_base.
%#######################################################################
%logica de guardar a el archivo
guardar_base :- tell('baseconocimiento.pl'), listing(lista/2), told.
%#######################################################################
%logica de la logitud de la lista
longitud(NL, R) :-lista(NL, Lt), length(Lt, R).
%#######################################################################
%logica de organizar por sort
organizar(NL, Lr) :- lista(NL, Lt), sort(Lt, Lr).
%#######################################################################

