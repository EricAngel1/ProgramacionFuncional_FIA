
//Miembros del Equipo 7
//Angel Alexis Serrano Hernandez - 219906183
//Eric Eduardo Angel Angel - 223992884
//Carlos González Rodríguez - 220886978
//Lizeth Gutiérrez Torres - 220616369
//Cristhian German  Ramírez  Ruiz - 223992922


(*
    Bueno, como introduccion inicial, el programa hemos hecho mediante un menu
    para que podamos ver en ejecucion diferentes ejemplos algunas caracteristicas claves de
    la programacion funcional. En este caso como primer inicio, ya aplicamos una de las caracteristicas que es la recursividad
    en el menu de la funcion, lo facilita el codigo y lo hace mas limpio.

    Para este caso, impelementamos al menos 3 caracteristicas comunes, que es:
    1. Funcion Pura: que todo lo que entra, produce la misma salida
    2. Funciones de Primera Clase: tratar funciones como variables y Orden Superior: aquellas que reciben funciones de primera clase como argumentos o devuelven otras funciones
    3. Recursividad: Este es otra caracteristica que evita mayormente el uso de los bucles mutables o lógica condicional.

    Y pues practicamente seria el uso de este programa, ejemplos basicos para poder entender la programacion funcional.
*)

//Aqui ya estamos aplicando una de las caracteristicas de la programacion funcional
// Por ejemplo en esta funcion, necesitamos poner "rec" para que pueda llamarse a si misma sin usar ningun bucle
let rec menu() =

    //En este caso se implemento un menu simple de las caracteristicas de la programacion funcional
    printfn ""
    printfn "############## Caracteristicas Pro. Funcional ##############"
    printfn "1- Funcion Pura."
    printfn "2- Funciones de Primera Clase y Orden Superior."
    printfn "3- Recursividad."
    printfn "4- Salir."
    printfn "#############################################"
    printf "Escoge una opcion (1-4): " 
    
    let opcion = System.Console.ReadLine()

    //creamos un switch pero con la sintaxis de F#
    match opcion with
    | "1" ->

    // Aqui ya aplicamos la funcion pura
        let sumar x y = x + y // siempre devuelve el mismo resultado con los mismas variables
        let resultado = sumar 5 20
        printfn "====================================="
        printfn "La suma es: %d" resultado
        printfn "====================================="

        menu()
    | "2" ->
        // Funciones de Primera Clase y Orden Superior
        // Función normal
        let multiplicar x y = x * y

        // Funciones de primera clase
        // Se pueden guardar en variables, pasar como argumento y devolver
        let operacion = multiplicar

        let resultadoPrimeraClase = operacion 5 3
        printfn "Resultado Multiplicación 5 + 3 = %d" resultadoPrimeraClase

        // Función de orden superior
        // Recibe otra función como parámetro
        let dosVeces f valor =
            f (f valor)

        let porDos numero = numero * 2
        let entreDos numero = numero / 2.0
        let resultadoPorDos = dosVeces porDos 4
        let resultatoEntreDos = dosVeces entreDos 18

        printfn "Aplicar dos veces por dos 4 = %d" resultadoPorDos
        printfn "Aplicar dos veces entre dos 18 = %.1f" resultatoEntreDos
        
        menu()
    | "3" ->
        // Recursividad con Pattern Matching
        // En lugar de usar "if/else", usamos coincidencia de patrones para definir la función factorial
        // Esto define el comportamiento de la función factorial para diferentes casos

        let rec factorial n =
            match n with
            | 0 | 1 -> 1 // Caso base: factorial de 0 o 1 es 1 
            | x -> x * factorial (x - 1) // Caso recursivo: n! = n * (n-1)!


        // Pedimos al usuario un número para calcular su factorial
        printf "Ingresa un número para calcular su factorial: "
        let numero = System.Console.ReadLine() |> int

        // Calculamos el factorial usando la función recursiva y mostramos el resultado
        let resultadoFactorial = factorial numero
        printfn "El factorial de %d es %d" numero resultadoFactorial
        printfn "====================================="
        menu()
    | "4" ->
        printfn "====================================="
        printfn "Gracias por su atencion"
        printfn "====================================="
    | _ ->
        printfn "====================================="
        printfn "Escoge bien la opcion brother"
        printfn "====================================="
        menu()

//Ya aqui mandamos a llamar la funcion, para que genere el apartado en la consola y asi interactuar en ella.
menu()

