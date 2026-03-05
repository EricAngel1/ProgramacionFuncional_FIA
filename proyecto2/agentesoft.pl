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

concatenar([],L2,L2).
concatenar([H|T],L2,[H|L3]):- concatenar(T,L2,L3).

longitud([],0).
longitud([_|T], N) :- longitud(T, N1), N is N1 + 1.