with Pkg_Tipos;    use Pkg_Tipos;
with Pkg_graficos; use Pkg_graficos;

package body Pkg_Objetos_Protegidos is

   protected body Ocupacion_OP is

      entry Intentar_Volar (avion : Ptr_T_RecordAvion)
        when N_Aviones_Array (avion.Aerovia) < 3
        and
          nombre_array (avion.Aerovia)
            (Posicion_Zonaespacioaereo (Avion.Pos.X))
          = False
        and
          nombre_array (avion.Aerovia)
            (Posicion_Zonaespacioaereo
               (Nueva_Posicionx (Avion.Pos.X, Avion.Velocidad.x)))
          = False
      is
         X_New : T_CoordenadaX;
      begin
         N_Aviones_Array (avion.Aerovia) :=
           N_Aviones_Array (avion.Aerovia) + 1;

         X_New := Nueva_Posicionx (Avion.Pos.X, Avion.Velocidad.x);

         nombre_array (avion.Aerovia)
           (Posicion_Zonaespacioaereo (Avion.Pos.X)) :=
           True;
         nombre_array (avion.Aerovia) (Posicion_Zonaespacioaereo (X_new)) :=
           True;
      end Intentar_Volar;

      entry Intentar_Desvolar (avion : Ptr_T_RecordAvion)
        when N_Aviones_Array (avion.Aerovia) > 0
      is
      begin
         N_Aviones_Array (avion.Aerovia) :=
           N_Aviones_Array (avion.Aerovia) - 1;
      end Intentar_desVolar;

      entry Intentar_Avanzar (avion : Ptr_T_RecordAvion) when True is
         Pos_Actual, Pos_Nueva : T_Rango_Rejilla_X;
      begin
         Pos_Actual := Posicion_Zonaespacioaereo (Avion.Pos.X);

         Pos_Nueva :=
           Posicion_Zonaespacioaereo
             (Nueva_Posicionx (Avion.Pos.X, Avion.Velocidad.X));

         nombre_array (avion.Aerovia) (Pos_Actual - 1) := False;
         nombre_array (avion.Aerovia) (Pos_Actual) := False;
         nombre_array (avion.Aerovia) (Pos_Actual + 1) := False;

         nombre_array (avion.Aerovia) (Pos_Nueva - 1) := True;
         nombre_array (avion.Aerovia) (Pos_Nueva) := True;
         nombre_array (avion.Aerovia) (Pos_Nueva + 1) := True;
      end Intentar_Avanzar;

   end Ocupacion_OP;

end Pkg_Objetos_Protegidos;
