%Creación de listas conforme al tema de robot DaVinci
:- dynamic lista/2.

lista(evapreoperacion, [historial_clinico, examenes_laboratorio, evaluacion_preanestesica, consentimiento_informados]).
lista(modulointeligente, [evaluacion_preoperacion, frecuencia_cardiaca, hemorragia, infeccion, niveles_de_riesgo, presion_arterial, probabilidad_de_complicaciones, signos_vitales]).
lista(operacion, [ginecologia, otorrinolaringologia, urologia, cirugia_general]).
lista(versiones, [s, sp, x, xi]).
lista(robothw, [torre_de_vision, consola_del_cirujano, carro_del_paciente]).
lista(robotsw, [funcionalidad_avanzada, gestion_de_datos, simulacion]).

