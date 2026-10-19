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

      select
         Pkg_Objetos_Protegidos.Ocupacion_Op_Global.Intentar_Volar (ptr_avion);
         Aparece (Ptr_Avion.all);
         loop
            Pkg_Objetos_Protegidos.Ocupacion_Op_Global.Intentar_Avanzar
              (ptr_avion);
            Actualiza_Movimiento (Ptr_Avion.all);
            delay (RETARDO_MOVIMIENTO);
         end loop;
         Pkg_Objetos_Protegidos.Ocupacion_Op_Global.Intentar_Desvolar
           (Ptr_avion);
      or
         delay until Retraso;
         Ptr_Avion.Color := Orange;
      end select;

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

end pkg_tareas_dinamicas;
