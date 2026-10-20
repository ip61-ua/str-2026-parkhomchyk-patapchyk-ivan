with Pkg_Tipos; use Pkg_Tipos;

package Pkg_Objetos_Protegidos is

   subtype T_Num_Aviones is Integer range 0 .. MAX_AVIONES_AEROVIA;

   type T_Array_N_Aviones is array (T_Rango_AeroVia) of T_Num_Aviones;
   type T_Array_Ocupacion is array (T_Rango_AeroVia) of T_Rejilla_Ocupacion;

   protected type Ocupacion_OP is

      entry lock (Ptr_Avion : Ptr_T_RecordAvion);
      procedure unlock (Ptr_Avion : Ptr_T_RecordAvion);
      entry Zona_seguridad;
      procedure actualizame;
      --entry Actualizar (Ptr_Avion : Ptr_T_RecordAvion);

   private

      procedure Escribir (X1 : T_Rango_Rejilla_X; v : Boolean);
      function alrededor (X1 : T_Rango_Rejilla_X) return boolean;
      function Seguridad_ocupada return Boolean;
      function Supera_permitido return Boolean;
      function es_inicio return Boolean;
      function es_final return Boolean;
      procedure Puedo_Avanzar (Result : out Boolean);

      N_Aviones_Array : T_Array_N_Aviones := (others => 0);
      Nombre_Array    : T_Array_Ocupacion := (others => (others => False));
      a               : Ptr_T_RecordAvion;

   end Ocupacion_OP;

   Ocupacion_Op_Global : Ocupacion_Op;

end Pkg_Objetos_Protegidos;
