--******************* PKG_TORRE_CONTROL.ADB *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_graficos;
with PKG_debug;
with Ada.Exceptions;         use Ada.Exceptions;
with Ada.Calendar;           use Ada.Calendar;
with Pkg_Objetos_Protegidos; use Pkg_Objetos_Protegidos;
with Ada.Text_Io;            use Ada.Text_Io;

package body PKG_Torre_Control is

   -----------------------------------------------------------------------
   -- DEFINICIÓN DE LA TAREA DE LA TORRE DE CONTROL
   -----------------------------------------------------------------------
   task body Tarea_Torre_Control is
      Atender_Descensos : Boolean := False;
      Coffee_time       : Boolean := False;
      type T_Pista_Circular is mod 2;
      proxima_pista     : T_Pista_Circular := T_Pista_Circular'First;
   begin

      PKG_debug.Escribir ("======================INICIO TASK Torre_Control");

      accept Iniciar_Torre_Control do
         Atender_Descensos := True;
      end Iniciar_Torre_Control;

      loop
         select
            accept Permiso_Descenso
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
            end Permiso_Descenso;
         or
            accept Asignar_pista (pista : out T_Rango_pista) do
               Pista :=
                 T_Rango_Pista'Val (1 + T_Rango_Pista'Val (proxima_pista));
               proxima_pista := proxima_pista + 1;
               Coffee_Time := true;
            end Asignar_pista;
         or
            accept Permiso_Aterrizaje (pista : in T_Rango_pista) do
               -- if T_Rango_Pista = 0 then
               --    return;
               -- end if;
               Coffee_Time := true;
               requeue Pista_Aterrizaje (T_Rango_Pista'val (Pista))
                        .Acceder_A_Pista;
            end Permiso_Aterrizaje;
         or
            accept salir_Aterrizaje (Pista : in T_Rango_pista) do
               Pista_Aterrizaje (pista).Liberar_Pista;
               Coffee_Time := true;
            end Salir_Aterrizaje;
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

   protected body T_Op_Pista_Aterrizaje is
      entry Acceder_A_Pista when not Ocupada is
      begin
         Ocupada := True;
      end Acceder_A_Pista;
      procedure Liberar_Pista is
      begin
         Ocupada := false;
      end Liberar_Pista;
   end T_Op_Pista_Aterrizaje;

end PKG_Torre_Control;
