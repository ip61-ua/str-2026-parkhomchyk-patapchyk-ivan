with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Exceptions;         use Ada.Exceptions;
with PKG_debug;              use PKG_debug;
with PKG_graficos;           use PKG_graficos;
with PKG_tipos;              use PKG_tipos;
with Ada.Real_time;          use Ada.Real_time;
with Pkg_Objetos_Protegidos; use Pkg_Objetos_Protegidos;

package body Pkg_tareas_dinamicas is

   task body T_Tarea_Avion is
      retraso : Time := Clock + To_Time_Span (Duration (1));
   begin

      select
         delay until retraso;
         Ptr_Avion.Color := Orange;
         retraso := Retraso + To_Time_Span (Duration (1));
         Imprimir (Ptr_Avion);
         Ocupacion_Op_Global.unlock (ptr_avion);
      then abort
         Ocupacion_Op_Global.Lock (ptr_avion);
         Ocupacion_Op_Global.Zona_seguridad;
         Imprimir (Ptr_Avion);
         Aparece (Ptr_Avion.all);
         Ocupacion_Op_Global.unlock (ptr_avion);
      end select;

      loop
         Ocupacion_Op_Global.Lock (ptr_avion);
         Ocupacion_Op_Global.actualizame;
         Actualiza_Movimiento (Ptr_Avion.all);
         Ocupacion_Op_Global.unlock (ptr_avion);
         delay (RETARDO_MOVIMIENTO);
      end loop;

   exception
      when DETECTADA_POSIBLE_COLISION =>
         PKG_debug.Escribir
           ("El avión con id "
            & T_IdAvion'Image (ptr_avion.id)
            & " no puede despegar por colisión");
         Desaparece (Ptr_Avion.all);
      when event : others =>
         PKG_debug.Escribir
           ("ERROR en TASK ….: "
            & Exception_Name (Exception_Identity (event))
            & " "
            & Exception_Message (event));

   end T_Tarea_Avion;

   procedure Imprimir (Ptr_Avion : Ptr_T_RecordAvion) is
   begin
      Put_line
        ("TASK Avion{"
         & " id ="
         & T_IdAvion'Image (ptr_avion.id)
         & " pos = ("
         & T_Coordenadax'image (ptr_avion.Pos.X)
         & ","
         & T_Coordenaday'image (ptr_avion.Pos.y)
         & ") "
         & " velocidad =("
         & T_RangoVelocidad'image (ptr_avion.velocidad.X)
         & ","
         & T_RangoVelocidad'image (ptr_avion.velocidad.y)
         & ") "
         & " color ="
         & T_Color'Image (ptr_avion.color)
         & " aereovia ="
         & T_Rango_Aerovia'Image (ptr_avion.aeRovia)
         & " aereovia_inicial ="
         & T_Rango_Aerovia'Image (Ptr_Avion.aerovia_inicial)
         & " pista ="
         & T_Rango_Pista'Image (Ptr_Avion.pista)
         & " tren_aterrizaje ="
         & Boolean'Image (Ptr_Avion.tren_aterrizaje)
         & " }");
   end Imprimir;

end pkg_tareas_dinamicas;
