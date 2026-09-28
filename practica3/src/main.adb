with Ada.Integer_Text_IO;  USE Ada.Integer_Text_IO;
with Ada.Text_Io;          use Ada.Text_Io;
with pkg_graficos;         use pkg_graficos;
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

   task Window_Simulator;
   task body Window_Simulator is
   begin
      Pkg_Graficos.Simular_Sistema;
   end;

begin
   Pkg_Custom_Aleatorio.Reset (Generador);
   for id in T_IdAvion loop
      for aerovia in T_Rango_AereoVia'First .. 4 loop
         -- T_Rango_AereoVia'Last loop

         -- inicializar datos de un nuevo avion
         ptr_avion := new T_RecordAvion;

         ptr_avion.id := id;
         if (Aerovia mod 2) = 0 then
            ptr_avion.velocidad.x := -T_Rangovelocidad'last;
         else
            ptr_avion.velocidad.x := T_Rangovelocidad'last;
         end if;
         Ptr_Avion.Pos := Pos_Inicio (aerovia);
         ptr_avion.velocidad.y := 0;
         ptr_avion.tren_aterrizaje := False;
         ptr_avion.aereovia := aerovia;
         ptr_avion.aereovia_inicial := aerovia;
         ptr_avion.color := blue;
         ptr_avion.pista := SIN_PISTA;

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
end main;
