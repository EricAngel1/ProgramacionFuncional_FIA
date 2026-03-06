%Creación de listas conforme al tema de robot DaVinci
%lista1
robothw([torre_de_vision, consola_del_cirujano, carro_del_paciente]).
%lista2
robotsw([conectividad, funcionalidad_avanzada,gestion_de_datos,simulacion]).
%lista3
versiones([s,sp,x,xi]).
%lista4
evapreoperacion([historial_clinico, examenes_laboratorio,evaluacion_preanestesica, consentimiento_informados]).
%lista5
modulointeligente([evaluacion_preoperacion, frecuencia_cardiaca, hemorragia, infeccion, niveles_de_riesgo, presion_arterial, probabilidad_de_complicaciones, signos_vitales]).
%lista6

operacion([ginecologia, otorrinolaringologia,urologia,cirugia_general]).

:- dynamic robothw/1.
:- dynamic robotsw/1.
:- dynamic versiones/1.
:- dynamic evapreoperacion/1.
:- dynamic modulointeligente/1.
:- dynamic operacion/1.
