with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with PKG_debug;      use PKG_debug;
with PKG_graficos;   use PKG_graficos;
with PKG_tipos;      use PKG_tipos;

package body Pkg_tareas_dinamicas is

   task body T_Tarea_Avion is
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
         & T_Rango_Aereovia'Image (ptr_avion.aereovia)
         & " aereovia_inicial ="
         & T_Rango_Aereovia'Image (Ptr_Avion.aereovia_inicial)
         & " pista ="
         & T_PistaAterrizaje'Image (Ptr_Avion.pista)
         & " tren_aterrizaje ="
         & Boolean'Image (Ptr_Avion.tren_aterrizaje)
         & " }");

      Aparece (Ptr_Avion.all);
      loop
         Actualiza_Movimiento (Ptr_Avion.all);
         delay (RETARDO_MOVIMIENTO);
      end loop;

   exception
      when Detectada_Colision =>
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
