with Pkg_Tipos; use Pkg_Tipos;

package Pkg_Objetos_Protegidos is

   subtype T_Num_Aviones is Integer range 0 .. MAX_AVIONES_AEROVIA;

   protected type Ocupacion_OP is
      entry Zona_Seguridad (Ptr_Avion : Ptr_T_RecordAvion);
      procedure Actualizame
        (Ptr_Avion : Ptr_T_RecordAvion; Permiso_Avanzar : out Boolean);
   private
      function Seguridad_Ocupada return Boolean;
      function Supera_Permitido return Boolean;
      procedure Escribir (Ptr_Avion : Ptr_T_RecordAvion; V : Boolean);
      procedure Escribir_futuro (Ptr_Avion : Ptr_T_Recordavion; V : BOOLEAN);

      procedure Puedo_Avanzar
        (Ptr_Avion : Ptr_T_RecordAvion; Result : out Boolean);

      Contador : T_Num_Aviones := 0;
      Rejillas : T_Rejilla_Ocupacion := (others => false);
   end Ocupacion_OP;

   type T_Ocupacion_Op_Global is array (T_Rango_AeroVia) of Ocupacion_OP;
   Ocupacion_Op_Global : T_Ocupacion_Op_Global;

end Pkg_Objetos_Protegidos;
