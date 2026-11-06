with Pkg_Tipos; use Pkg_Tipos;

package pkg_tareas_dinamicas is

   task type T_Tarea_Avion (ptr_avion : Ptr_T_RecordAvion);
   type Ptr_Tarea_Avion is access T_Tarea_avion;

private
   procedure Imprimir (Ptr_Avion : Ptr_T_RecordAvion);
   procedure Inicio_naranja (Ptr_Avion : Ptr_T_RecordAvion);
   procedure Seguir_Volando (Ptr_Avion : Ptr_T_RecordAvion);
   procedure Maniobra_Bajar_Aerovia (Ptr_Avion : Ptr_T_RecordAvion);
   procedure Asignar_pista (Ptr_Avion : Ptr_T_Recordavion);
   function Esta_Asignada_Pista (Ptr_Avion : Ptr_T_Recordavion) return boolean;
end pkg_tareas_dinamicas;
