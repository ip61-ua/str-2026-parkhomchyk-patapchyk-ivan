with Pkg_Tipos;    use Pkg_Tipos;
with Pkg_graficos; use Pkg_graficos;
with Ada.Text_IO;  use Ada.Text_IO;

package body Pkg_Objetos_Protegidos is

   protected body Ocupacion_OP is
      entry Zona_Seguridad (Ptr_Avion : Ptr_T_Recordavion)
        when not Seguridad_Ocupada and Not Supera_Permitido
      is
      begin
         Escribir (Ptr_Avion, True);
         Contador := Contador + 1;
      end Zona_Seguridad;

      function Seguridad_Ocupada return Boolean is
      begin
         return
           Rejillas (T_Rango_Rejilla_X'First)
           or Rejillas (T_Rango_Rejilla_X'First + 1)
           or Rejillas (T_Rango_Rejilla_X'Last)
           or Rejillas (T_Rango_Rejilla_X'Last - 1);
      end Seguridad_Ocupada;

      function Supera_Permitido return Boolean is
      begin
         return contador >= MAX_AVIONES_AEROVIA;
      end Supera_Permitido;

      -- procedure Escribir_Pos
      --   (Aerovia : T_Rango_AeroVia; X1 : T_Rango_Rejilla_X; V : Boolean) is
      -- begin
      --    if X1 > T_Rango_Rejilla_X'First then
      --       Nombre_Array (Aerovia) (X1 - 1) := V;
      --    end if;
      --    Nombre_Array (Aerovia) (X1) := V;
      --    if X1 < T_Rango_Rejilla_X'Last then
      --       Nombre_Array (Aerovia) (X1 + 1) := V;
      --    end if;
      -- end Escribir_Pos;

      procedure Escribir (Ptr_Avion : Ptr_T_RecordAvion; V : Boolean) is
         X1 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
         X0 : T_Rango_Rejilla_X := X1 - 1;
         X2 : T_Rango_Rejilla_X := X1 + 1;
      begin
         Rejillas (x0) := V;
         Rejillas (x1) := V;
         Rejillas (x2) := V;
      end Escribir;

      function Alrededor (X1 : T_Rango_Rejilla_X) return Boolean is
         X0 : T_Rango_Rejilla_X := X1 - 1;
         X2 : T_Rango_Rejilla_X := X1 + 1;
      begin
         return Rejillas (x0) or Rejillas (x1) or Rejillas (x2);
      end Alrededor;

      -- function Es_Inicio (Ptr_Avion : Ptr_T_RecordAvion) return Boolean is
      --    T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
      -- begin
      --    return
      --      (T0 <= T_Rango_Rejilla_X'First and Ptr_Avion.Velocidad.X > 0)
      --      or (T0 >= T_Rango_Rejilla_X'Last and Ptr_Avion.Velocidad.X < 0);
      -- end Es_Inicio;

      -- function Es_Final (Ptr_Avion : Ptr_T_RecordAvion) return Boolean is
      --    T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
      -- begin
      --    return
      --      (T0 >= T_Rango_Rejilla_X'Last and Ptr_Avion.Velocidad.X > 0)
      --      or (T0 <= T_Rango_Rejilla_X'First and Ptr_Avion.Velocidad.X < 0);
      -- end Es_Final;

      procedure Escribir_futuro (Ptr_Avion : Ptr_T_Recordavion; V : BOOLEAN) is
         T1 : T_Rango_Rejilla_X :=
           Posicion_ZonaEspacioAereo
             (Nueva_PosicionX (Ptr_Avion.Pos.X, Ptr_Avion.Velocidad.X));
         T0 : T_Rango_Rejilla_X := T1 - 1;
         T2 : T_Rango_Rejilla_X := T1 + 1;
      begin
         Rejillas (T0) := V;
         Rejillas (T1) := V;
         Rejillas (T2) := V;
      end Escribir_futuro;

      procedure Puedo_Avanzar
        (Ptr_Avion : Ptr_T_RecordAvion; Result : out Boolean)
      is
         T1 : T_Rango_Rejilla_X :=
           Posicion_ZonaEspacioAereo
             (Nueva_PosicionX (Ptr_Avion.Pos.X, Ptr_Avion.Velocidad.X));
      begin
         Escribir (Ptr_Avion, False);
         Result := not Alrededor (T1);
         Escribir (Ptr_Avion, True);
      end Puedo_Avanzar;

      procedure Actualizame
        (Ptr_Avion : Ptr_T_Recordavion; Permiso_Avanzar : out Boolean)
      is
         T1 : T_Rango_Rejilla_X :=
           Posicion_ZonaEspacioAereo
             (Nueva_PosicionX (Ptr_Avion.Pos.X, Ptr_Avion.Velocidad.X));
      begin
         Puedo_Avanzar (Ptr_Avion, Permiso_Avanzar);

         if Permiso_Avanzar then
            Escribir (Ptr_Avion, false);
            Escribir_futuro (Ptr_Avion, true);
         end if;

      end Actualizame;

      procedure Reserva_Aerovia_Descenso (Exito : out Boolean) is
      begin
         Exito := not Supera_Permitido;

         if Exito then
            Contador := Contador + 1;
         end if;
      end Reserva_Aerovia_Descenso;

      procedure Hay_Hueco_Para_bajar
        (Ptr_Avion : Ptr_T_Recordavion; exito : out Boolean)
      is
         x : T_Rango_Rejilla_X := Posicion_Zonaespacioaereo (Ptr_Avion.Pos.X);
      begin
         Exito := Contador <= MAX_AVIONES_AEROVIA and not Alrededor (x);

         if Exito then
            Escribir (Ptr_avion, true);
         end if;
      end Hay_Hueco_Para_bajar;

      procedure desocupar (Ptr_Avion : Ptr_T_RecordAvion) is
      begin
         Escribir (Ptr_Avion, false);
         Contador := Contador - 1;
      end desocupar;

   end Ocupacion_OP;
end Pkg_Objetos_Protegidos;
