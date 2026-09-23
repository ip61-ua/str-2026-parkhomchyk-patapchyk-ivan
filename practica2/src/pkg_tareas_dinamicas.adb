with Ada.Text_IO; use Ada.Text_IO;

package body Pkg_tareas_dinamicas is

   task body T_Tarea_Avion is
   begin
      Put_line
        ("TASK Avion: "
         & T_IdAvion'Image (ptr_avion.id)
         & " -"
         & T_Rango_AereoVia'Image (ptr_avion.aereovia));
   end T_Tarea_Avion;

end pkg_tareas_dinamicas;
