with Pkg_Tipos;    use Pkg_Tipos;
with Pkg_graficos; use Pkg_graficos;
with Ada.Text_io;  use Ada.Text_io;

package body Pkg_Objetos_Protegidos is

   protected body Ocupacion_OP is

      entry lock (Ptr_Avion : Ptr_T_RecordAvion) when A = null is
      begin
         A := Ptr_Avion;
      end lock;

      procedure unlock (Ptr_Avion : Ptr_T_RecordAvion) is
      begin
         if (Ptr_Avion = a) then
            A := null;
         end if;
      end unlock;

      function Seguridad_ocupada return Boolean is
         Rejilla : T_Rejilla_Ocupacion := Nombre_Array (A.aerovia);
      begin
         return
           Rejilla (T_Rejilla_Ocupacion'First)
           or Rejilla (T_Rejilla_Ocupacion'First + 1)
           or Rejilla (T_Rejilla_Ocupacion'Last)
           or Rejilla (T_Rejilla_Ocupacion'Last - 1);
      end Seguridad_ocupada;

      function Supera_permitido return Boolean is
      begin
         return N_Aviones_Array (A.aerovia) > 3;
      end Supera_permitido;

      entry Zona_seguridad
        when not Seguridad_Ocupada and not Supera_Permitido and A /= null
      is
      begin
         Escribir (Posicion_ZonaEspacioAereo (A.Pos.x), true);
      end Zona_seguridad;

      procedure Puedo_Avanzar (Result : out Boolean) is
         T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (A.Pos.x);
         T1 : T_Rango_Rejilla_X :=
           Posicion_ZonaEspacioAereo
             (Nueva_PosicionX (A.Pos.X, A.Velocidad.x));
      begin
         Escribir (t0, false);
         Result := Alrededor (t1);
         Escribir (t0, true);
         -- return Result;
      end Puedo_avanzar;

      procedure actualizame -- when not Supera_Permitido and A /= null
      is
         T0              : T_Rango_Rejilla_X :=
           Posicion_ZonaEspacioAereo (A.Pos.x);
         T1              : T_Rango_Rejilla_X :=
           Posicion_ZonaEspacioAereo
             (Nueva_PosicionX (A.Pos.X, A.Velocidad.x));
         Permiso_Avanzar : Boolean;
      begin

         if Supera_Permitido then
            return;
         end if;

         if es_inicio then
            N_Aviones_Array (A.aerovia) := N_Aviones_Array (A.aerovia) + 1;

         elsif es_final then
            N_Aviones_Array (A.aerovia) := N_Aviones_Array (A.aerovia) - 1;
         end if;

         Puedo_Avanzar (Permiso_Avanzar);
         if Permiso_Avanzar then
            Escribir (t0, false);
            Escribir (t1, true);
         end if;

      end actualizame;

      function es_inicio return Boolean is
         T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (A.Pos.x);
      begin
         return
           (T0 <= (T_Rango_Rejilla_X'First) and A.Velocidad.x > 0)
           or (T0 >= (T_Rango_Rejilla_X'last) and A.Velocidad.x < 0);
      end es_inicio;

      function es_final return Boolean is
         T0 : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (A.Pos.x);
      begin
         return
           (T0 >= (T_Rango_Rejilla_X'last) and A.Velocidad.x > 0)
           or (T0 <= (T_Rango_Rejilla_X'First) and A.Velocidad.x < 0);
      end es_final;

      Procedure Escribir (X1 : T_RANGO_REJILLA_X; V : BOOLEAN) IS
         X0 : T_RANGO_REJILLA_X := X1 - 1;
         X2 : T_RANGO_REJILLA_X := X1 + 1;
      BEGIN
         NOMBRE_ARRAY (A.AEROVIA) (X0) := V;
         NOMBRE_ARRAY (A.AEROVIA) (X1) := V;
         NOMBRE_ARRAY (A.AEROVIA) (X2) := V;
      END ESCRIBIR;

      FUNCTION ALREDEDOR (X1 : T_RANGO_REJILLA_X) RETURN BOOLEAN IS
         REJILLA : T_REJILLA_OCUPACION := NOMBRE_ARRAY (A.AEROVIA);
      BEGIN
         RETURN
           REJILLA (T_RANGO_REJILLA_X (X1 + 1))
           OR REJILLA (T_RANGO_REJILLA_X (X1 - 1))
           OR REJILLA (X1);
      END ALREDEDOR;

   END OCUPACION_OP;

END Pkg_Objetos_Protegidos;
