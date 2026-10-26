--******************* PKG_TORRE_CONTROL.ADB *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_graficos;
with PKG_debug;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Calendar;   use Ada.Calendar;

PACKAGE BODY PKG_Torre_Control IS

   -----------------------------------------------------------------------
   -- DEFINICIÓN DE LA TAREA DE LA TORRE DE CONTROL
   -----------------------------------------------------------------------
   TASK BODY Tarea_Torre_Control IS
      Atender_Descensos : Boolean := False;
   BEGIN
      PKG_debug.Escribir ("======================INICIO TASK Torre_Control");
      select
         ACCEPT Iniciar_Torre_Control DO
            Atender_Descensos := True;
         END Iniciar_Torre_Control;
         -- or
         --  when Atender_Descensos
         --  =>accept Quiero_Descender (Ptr_Avion : Ptr_T_Recordavion) do
         -- end Quiero_Descender;

         -- delay Duration (2);
      end select;

   exception
      when event : others =>
         PKG_debug.Escribir
           ("ERROR en TASK Torre_Control: "
            & Exception_Name (Exception_Identity (event)));

   END Tarea_Torre_Control;

end PKG_Torre_Control;
