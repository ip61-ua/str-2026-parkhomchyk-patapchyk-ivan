with pkg_tareas_estaticas; use pkg_tareas_estaticas;

-- 7.a) Este programa principal lo que hará es crear y activar tareas. La tarea padre esperará hasta que todas sus tareas generadas finalicen.
-- lo que ocurre es:
-- 1. Poner "Sentencias de Inicialización ..." 
-- 2. Esperar un porquito.
-- 3. Empezar a imprimir 20 veces por 3 números entre los rangos solicitados.
-- 4. Terminar.
-- De hecho observamos un comportamiento de condición de carrera porque la impresión de estos números no es siempre igual. Vemos ocasiones en las que se imprime dos veces en la misma línea o doble salto de línea.
procedure main_tareas_estaticas is
   tarea1 : T_Tarea(0,9);
   tarea2 : T_Tarea(10,99);
   tarea3 : T_Tarea(100,999);
begin
   null;
end main_tareas_estaticas;
