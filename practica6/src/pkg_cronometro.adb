with Ada.Calendar; use Ada.Calendar;
with Pkg_Graficos; use Pkg_Graficos;

package body Pkg_Cronometro is
   task body T_Tarea_Actualizar_Crono is
      periodo   : constant Duration := Duration (1);
      Antes     : Time := Clock;
      Siguiente : Time := Clock;
      Entre     : Duration;
   begin
      loop
         entre := Siguiente - Antes;
         Actualiza_Cronometro (entre);
         Siguiente := Siguiente + Periodo;
         delay (periodo);
         -- delay until (siguiente);
      end loop;
   end T_Tarea_Actualizar_Crono;
end Pkg_Cronometro;
