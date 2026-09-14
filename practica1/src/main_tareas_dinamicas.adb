with pkg_tareas_dinamicas;

-- 8.b) con esto ya se crean las tareas estáticas del paquete automáticamente. 
procedure main_tareas_dinamicas is
   -- 1.
   -- type ptr_generador is access pkg_tareas_dinamicas.TareaGeneraAviones;
   -- 2.
   -- generador: pkg_tareas_dinamicas.TareaGeneraAviones;
begin
   -- 1. (VER ESTO)
   -- ptr_generador := new pkg_tareas_dinamicas.TareaGeneraAviones;
   null;
end main_tareas_dinamicas;
