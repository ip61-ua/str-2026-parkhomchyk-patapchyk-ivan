with Pkg_Tipos; use Pkg_Tipos;

package Pkg_Objetos_Protegidos is

   subtype T_Num_Aviones is Integer range 0 .. MAX_AVIONES_AEROVIA;

   type T_Array_N_Aviones is array (T_Rango_AeroVia) of T_Num_Aviones;
   type T_Array_Ocupacion is array (T_Rango_AeroVia) of T_Rejilla_Ocupacion;

   protected type Ocupacion_OP is

   Private
      N_Aviones_Array : T_Array_N_Aviones := (others => 0);
      Nombre_Array    : T_Array_Ocupacion := (others => (others => False));

   end Ocupacion_OP;

   Ocupacion_Op_Global : Ocupacion_Op;

end Pkg_Objetos_Protegidos;
