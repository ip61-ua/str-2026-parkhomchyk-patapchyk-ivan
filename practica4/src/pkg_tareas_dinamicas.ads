with Pkg_Tipos; use Pkg_Tipos;

package pkg_tareas_dinamicas is

   task type T_Tarea_Avion (ptr_avion : Ptr_T_RecordAvion);
   type Ptr_Tarea_Avion is access T_Tarea_avion;

private
   procedure Imprimir (Ptr_Avion : Ptr_T_RecordAvion);

end pkg_tareas_dinamicas;
