with Ada.Real_Time; use Ada.Real_Time;
with Pkg_Graficos;  use Pkg_Graficos;

package body Pkg_Cronometro_real is
   task body T_Tarea_Actualizar_Crono is
      periodo   : constant Time_Span := To_Time_Span (Duration (1));
      Antes     : Time := Clock;
      Siguiente : Time := Clock;
      Entre     : Time_Span;
      Entre_D   : Duration;
   begin
      loop
         entre := Siguiente - Antes;
         Entre_D := To_Duration (Entre);
         Actualiza_Cronometro (Entre_D);
         Siguiente := Siguiente + Periodo;
         -- delay (Entre_D);
         delay (1.0);
         -- delay until (siguiente);
      end loop;
   end T_Tarea_Actualizar_Crono;
end Pkg_Cronometro_real;
