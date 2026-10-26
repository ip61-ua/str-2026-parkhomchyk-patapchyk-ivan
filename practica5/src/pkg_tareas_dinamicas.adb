with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Exceptions;         use Ada.Exceptions;
with PKG_debug;              use PKG_debug;
with PKG_graficos;           use PKG_graficos;
with PKG_tipos;              use PKG_tipos;
with Ada.Calendar;           use Ada.Calendar;
with Pkg_Objetos_Protegidos; use Pkg_Objetos_Protegidos;

package body Pkg_tareas_dinamicas is

   task body T_Tarea_Avion is
      antes  : Time := Clock;
      ahora  : Time;
      Avanzo : Boolean := False;
   begin
      loop
         declare
         begin
            Ocupacion_Op_Global (Ptr_Avion.aerovia).Zona_Seguridad (Ptr_Avion);
            Ahora := Clock;

            if Ahora - Antes > Duration (1) then
               Ptr_Avion.Color := Orange;
            end if;
            Imprimir (Ptr_Avion);

            Aparece (Ptr_Avion.all);

            loop
               Ocupacion_Op_global (Ptr_Avion.aerovia).Actualizame
                 (Ptr_Avion, Avanzo);

               if Avanzo then
                  Actualiza_Movimiento (Ptr_Avion.all);
               end if;

               delay (RETARDO_MOVIMIENTO);
            end loop;

         exception
            when DETECTADA_POSIBLE_COLISION =>
               PKG_debug.Escribir
                 ("El avión con id "
                  & T_IdAvion'Image (Ptr_Avion.Id)
                  & " no puede despegar por colisión");
               Desaparece (Ptr_Avion.all);

            when Event : others =>
               PKG_debug.Escribir
                 ("ERROR en TASK ....: "
                  & Exception_Name (Exception_Identity (Event))
                  & " "
                  & Exception_Message (Event));
         end;
      end loop;
   end T_Tarea_Avion;

   procedure Imprimir (Ptr_Avion : Ptr_T_RecordAvion) is
   begin
      if Ptr_Avion /= null then
         Put_Line
           ("TASK Avion{"
            & " id ="
            & T_IdAvion'Image (Ptr_Avion.Id)
            & " pos = ("
            & T_Coordenadax'Image (Ptr_Avion.Pos.X)
            & ","
            & T_Coordenaday'Image (Ptr_Avion.Pos.Y)
            & ") "
            & " velocidad =("
            & T_RangoVelocidad'Image (Ptr_Avion.Velocidad.X)
            & ","
            & T_RangoVelocidad'Image (Ptr_Avion.Velocidad.Y)
            & ") "
            & " color ="
            & T_Color'Image (Ptr_Avion.Color)
            & " aereovia ="
            & T_Rango_Aerovia'Image (Ptr_Avion.Aerovia)
            & " aereovia_inicial ="
            & T_Rango_Aerovia'Image (Ptr_Avion.Aerovia_Inicial)
            & " pista ="
            & T_Rango_Pista'Image (Ptr_Avion.Pista)
            & " tren_aterrizaje ="
            & Boolean'Image (Ptr_Avion.Tren_Aterrizaje)
            & " }");
      end if;
   end Imprimir;

end Pkg_tareas_dinamicas;
