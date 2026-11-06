--******************* PKG_TORRE_CONTROL.ADS *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_tipos; use PKG_tipos;

PACKAGE PKG_Torre_Control IS

   task Tarea_Torre_Control IS
      entry Iniciar_Torre_Control;
      entry Permiso_Descenso
        (Ptr_Avion : Ptr_T_Recordavion; Permitido : out Boolean);
      entry Asignar_pista (pista : out T_Rango_pista);
      entry Permiso_Aterrizaje (Pista : in T_Rango_pista);
      --      entry salir_Aterrizaje (Pista : in T_Rango_pista);
   END Tarea_Torre_Control;

   protected type T_Op_Pista_Aterrizaje is
      entry Acceder_A_pista;
      procedure Liberar_Pista;
   private
      Ocupada : Boolean := False;
   end T_Op_Pista_Aterrizaje;

private
   Pista_Aterrizaje : array (1 .. 2) of T_Op_Pista_Aterrizaje;

end PKG_Torre_Control;
