--******************* PKG_TORRE_CONTROL.ADB *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_graficos;
with PKG_debug;
with Ada.Exceptions;         use Ada.Exceptions;
with Ada.Calendar;           use Ada.Calendar;
with Pkg_Objetos_Protegidos; use Pkg_Objetos_Protegidos;

package body PKG_Torre_Control is

   -----------------------------------------------------------------------
   -- DEFINICIÓN DE LA TAREA DE LA TORRE DE CONTROL
   -----------------------------------------------------------------------
   task body Tarea_Torre_Control is
      Atender_Descensos : Boolean := False;
      Coffee_time       : Boolean := False;
   begin
      PKG_debug.Escribir ("======================INICIO TASK Torre_Control");

      loop
         select
            when Atender_Descensos
            =>accept Quiero_Descender
              (Ptr_Avion : Ptr_T_Recordavion; Permitido : out Boolean)
            do
               declare
                  via_Actual : T_Rango_AeroVia := Ptr_Avion.Aerovia;
                  via_futuro : T_Rango_AeroVia := via_Actual + 1;
               begin
                  Ocupacion_Op_Global (T_Rango_AeroVia (via_futuro))
                    .Reserva_Aerovia_Descenso (Permitido);
               end;
               Coffee_Time := true;
            end Quiero_Descender;
         or
            when not Atender_Descensos
            =>accept Iniciar_Torre_Control do
               Atender_Descensos := True;
            end Iniciar_Torre_Control;
         end select;

         if Coffee_Time then
            Coffee_Time := False;
            delay Duration (2);
         end if;
      end loop;

   exception
      when event : others =>
         PKG_debug.Escribir
           ("ERROR en TASK Torre_Control: "
            & Exception_Name (Exception_Identity (event)));

   end Tarea_Torre_Control;

end PKG_Torre_Control;
