with Ada.Integer_Text_IO;  USE Ada.Integer_Text_IO;
with Ada.Text_Io;          use Ada.Text_Io;
with pkg_graficos;
with pkg_tipos;            use pkg_tipos;
with Ada.Numerics.Discrete_Random;
with Pkg_tareas_dinamicas; use Pkg_tareas_dinamicas;

procedure main is
   package Pkg_Custom_Aleatorio is new
     ada.numerics.discrete_random (t_retardoaparicionaviones);
   Generador   : Pkg_Custom_Aleatorio.Generator;
   Retardo     : T_Retardoaparicionaviones;
   tarea_avion : Ptr_Tarea_Avion;
   ptr_avion   : Ptr_T_RecordAvion;
begin
   -- Pkg_Graficos.Simular_Sistema;
   Pkg_Custom_Aleatorio.Reset (Generador);

   loop
      for id in T_IdAvion loop
         for aerovia in T_Rango_AereoVia'First .. T_Rango_AereoVia'Last loop

            -- inicializar datos de un nuevo avion
            ptr_avion := new T_RecordAvion;

            ptr_avion.id := id;
            ptr_avion.velocidad.x := VELOCIDAD_VUELO;
            ptr_avion.velocidad.y := 0;
            ptr_avion.tren_aterrizaje := False;
            ptr_avion.aereovia := aerovia;

            -- Crear una tarea para el comportamiento del avion
            tarea_avion := new T_Tarea_Avion (ptr_avion);

            Retardo := Pkg_Custom_Aleatorio.Random (Generador);
            Put ("Esperando ");
            Put (Item => Retardo, Width => 0);
            Put (" segundos...");
            New_Line;

            delay (Duration (Retardo));
         end loop;
      end loop;
   end loop;
end main;
