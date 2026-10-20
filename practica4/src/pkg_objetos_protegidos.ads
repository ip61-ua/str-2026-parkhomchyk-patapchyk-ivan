with Pkg_Tipos; use Pkg_Tipos;

package Pkg_Objetos_Protegidos is

   subtype T_Num_Aviones is Integer range 0 .. MAX_AVIONES_AEROVIA;

   type T_Array_N_Aviones is array (T_Rango_AeroVia) of T_Num_Aviones;
   type T_Array_Ocupacion is array (T_Rango_AeroVia) of T_Rejilla_Ocupacion;

   protected type Ocupacion_OP is

      entry P (Avion : Ptr_T_RecordAvion);
      entry A_Punto_De_volar;
      function Esta_ocupado
        (via              : T_Rango_Aerovia;
         P_X0, P_X1, P_x2 : T_Rango_Rejilla_X;
         P_B0, P_B2       : boolean) return boolean;
      procedure ocupar
        (via              : T_Rango_Aerovia;
         p_X0, p_X1, P_x2 : T_Rango_Rejilla_X;
         P_B0, P_B2, Val  : Boolean);
      Procedure V (Avion : Ptr_T_RecordAvion);
      Procedure Actualiza (Avion : Ptr_T_RecordAvion);
      procedure Computa_Zona_Posicion (Av : Ptr_T_RecordAvion);
      function Es_Final (Avion : Ptr_T_RecordAvion) return boolean;

   Private
      N_Aviones_Array  : T_Array_N_Aviones := (others => 0);
      Nombre_Array     : T_Array_Ocupacion := (others => (others => False));
      A                : Ptr_T_Recordavion := Null;
      X0, X1, X2       : T_Rango_Rejilla_X;
      F_X0, F_X1, F_x2 : T_Rango_Rejilla_X;
      B0, B2           : Boolean;
      F_B0, F_B2       : Boolean;

   end Ocupacion_OP;

   Ocupacion_Op_Global : Ocupacion_Op;

end Pkg_Objetos_Protegidos;
