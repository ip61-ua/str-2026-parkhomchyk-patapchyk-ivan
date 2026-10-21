with Pkg_Tipos;    use Pkg_Tipos;
with Pkg_graficos; use Pkg_graficos;
with Ada.Text_IO;  use Ada.Text_IO;

package body Pkg_Objetos_Protegidos is

   protected body Ocupacion_OP is

      entry Lock (Ptr_Avion : Ptr_T_RecordAvion) when A = null is
      begin
         A := Ptr_Avion;
      end Lock;

      procedure Unlock (Ptr_Avion : Ptr_T_RecordAvion) is
      begin
         if Ptr_Avion = A then
            A := null;
         end if;
      end Unlock;

      function Seguridad_Ocupada (Ptr_Avion : Ptr_T_RecordAvion) return Boolean
      is
         Rejilla : T_Rejilla_Ocupacion;
      begin
         if Ptr_Avion = null then
            return True;
         end if;
         Rejilla := Nombre_Array (Ptr_Avion.Aerovia);
         return
           Rejilla (T_Rango_Rejilla_X'First)
           or Rejilla (T_Rango_Rejilla_X'First + 1)
           or Rejilla (T_Rango_Rejilla_X'Last)
           or Rejilla (T_Rango_Rejilla_X'Last - 1);
      end Seguridad_Ocupada;

      function Supera_Permitido (Ptr_Avion : Ptr_T_RecordAvion) return Boolean
      is
      begin
         if Ptr_Avion = null then
            return True;
         end if;
         return N_Aviones_Array (Ptr_Avion.Aerovia) >= MAX_AVIONES_AEROVIA;
      end Supera_Permitido;

      procedure Zona_Seguridad
        (Ptr_Avion : Ptr_T_Recordavion; Surt : out Boolean)
      is

         Es_mio  : Boolean := A = Ptr_Avion;
         Ocupado : Boolean := Seguridad_Ocupada (Ptr_Avion);
         Supera  : Boolean := Supera_Permitido (Ptr_Avion);

      begin
         if (not Es_mio) or Ocupado or supera then
            Surt := False;
         else
            Escribir (Ptr_Avion, True);
            N_Aviones_Array (Ptr_Avion.Aerovia) :=
              N_Aviones_Array (Ptr_Avion.Aerovia) + 1;
            Surt := True;
         end if;
      end Zona_Seguridad;

      procedure Escribir_Pos
        (Aerovia : T_Rango_AeroVia; X1 : T_Rango_Rejilla_X; V : Boolean) is
      begin
         if X1 > T_Rango_Rejilla_X'First then
            Nombre_Array (Aerovia) (X1 - 1) := V;
         end if;
         Nombre_Array (Aerovia) (X1) := V;
         if X1 < T_Rango_Rejilla_X'Last then
            Nombre_Array (Aerovia) (X1 + 1) := V;
         end if;
      end Escribir_Pos;

      procedure Escribir (Ptr_Avion : Ptr_T_RecordAvion; V : Boolean) is
         X1 : T_Rango_Rejilla_X;
      begin
         if Ptr_Avion /= null then
            X1 := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
            Escribir_Pos (Ptr_Avion.Aerovia, X1, V);
         end if;
      end Escribir;

      function Alrededor
        (Aerovia : T_Rango_AeroVia; X1 : T_Rango_Rejilla_X) return Boolean
      is
         Rejilla : T_Rejilla_Ocupacion := Nombre_Array (Aerovia);
         Res     : Boolean := Rejilla (X1);
      begin
         if X1 > T_Rango_Rejilla_X'First then
            Res := Res or Rejilla (X1 - 1);
         end if;
         if X1 < T_Rango_Rejilla_X'Last then
            Res := Res or Rejilla (X1 + 1);
         end if;
         return Res;
      end Alrededor;

      function Es_Inicio (Ptr_Avion : Ptr_T_RecordAvion) return Boolean is
         T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
      begin
         return
           (T0 <= T_Rango_Rejilla_X'First and Ptr_Avion.Velocidad.X > 0)
           or (T0 >= T_Rango_Rejilla_X'Last and Ptr_Avion.Velocidad.X < 0);
      end Es_Inicio;

      function Es_Final (Ptr_Avion : Ptr_T_RecordAvion) return Boolean is
         T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
      begin
         return
           (T0 >= T_Rango_Rejilla_X'Last and Ptr_Avion.Velocidad.X > 0)
           or (T0 <= T_Rango_Rejilla_X'First and Ptr_Avion.Velocidad.X < 0);
      end Es_Final;

      procedure Puedo_Avanzar
        (Ptr_Avion : Ptr_T_RecordAvion; Result : out Boolean)
      is
         T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
         T1 : T_Rango_Rejilla_X :=
           Posicion_ZonaEspacioAereo
             (Nueva_PosicionX (Ptr_Avion.Pos.X, Ptr_Avion.Velocidad.X));
      begin
         Escribir (Ptr_Avion, False);
         Result := not Alrededor (Ptr_Avion.Aerovia, T1);
         Escribir (Ptr_Avion, True);
      end Puedo_Avanzar;

      procedure Actualizame (Ptr_Avion : Ptr_T_RecordAvion) is
         T0              : T_Rango_Rejilla_X;
         T1              : T_Rango_Rejilla_X;
         Permiso_Avanzar : Boolean;
      begin
         if Ptr_Avion = null or Supera_Permitido (Ptr_Avion) then
            return;
         end if;

         T0 := Posicion_ZonaEspacioAereo (Ptr_Avion.Pos.X);
         T1 :=
           Posicion_ZonaEspacioAereo
             (Nueva_PosicionX (Ptr_Avion.Pos.X, Ptr_Avion.Velocidad.X));

         Puedo_Avanzar (Ptr_Avion, Permiso_Avanzar);
         if Permiso_Avanzar then
            Escribir (Ptr_Avion, False);
            if Es_Final (Ptr_Avion) then
               if N_Aviones_Array (Ptr_Avion.Aerovia) > 0 then
                  N_Aviones_Array (Ptr_Avion.Aerovia) :=
                    N_Aviones_Array (Ptr_Avion.Aerovia) - 1;
               end if;
            else
               Escribir_Pos (Ptr_Avion.Aerovia, T1, True);
            end if;
         end if;

      end Actualizame;

   end Ocupacion_OP;

end Pkg_Objetos_Protegidos;
