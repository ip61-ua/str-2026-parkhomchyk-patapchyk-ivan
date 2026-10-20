with Pkg_Tipos;    use Pkg_Tipos;
with Pkg_graficos; use Pkg_graficos;
with Ada.Text_io;  use Ada.Text_io;

package body Pkg_Objetos_Protegidos is

   protected body Ocupacion_OP is

      entry P (Avion : Ptr_T_RecordAvion) when a = null is
      begin
         A := Avion;
         Computa_Zona_Posicion (a);
      end P;

      procedure Computa_Zona_Posicion (Av : Ptr_T_RecordAvion) is
      begin

         x1 := Posicion_Zonaespacioaereo (Av.Pos.x);
         x0 := x1 - 1;
         x2 := X1 + 1;

         B0 := X0 > X1;
         B2 := X1 > X2;

         F_X1 :=
           Posicion_Zonaespacioaereo
             (Nueva_Posicionx (Av.Pos.X, Av.Velocidad.x));
         F_x0 := F_x1 - 1;
         F_x2 := F_X1 + 1;

         F_B0 := F_X0 > F_X1;
         F_B2 := F_X1 > F_X2;

      end Computa_Zona_Posicion;

      function Esta_ocupado
        (via              : T_Rango_Aerovia;
         P_X0, P_X1, P_x2 : T_Rango_Rejilla_X;
         P_B0, P_B2       : boolean) return boolean

      is
         Res : Boolean := Nombre_Array (via) (P_x1);
      begin

         if not P_B0 then
            Res := Nombre_Array (via) (P_x0) or Res;
         end if;

         if not P_B2 then
            Res := Res or Nombre_Array (via) (P_x2);
         end if;

         return Res;

      end Esta_ocupado;

      procedure Ocupar
        (via              : T_Rango_Aerovia;
         p_X0, p_X1, P_x2 : T_Rango_Rejilla_X;
         P_B0, P_B2, Val  : Boolean) is
      begin

         if not P_B0 then
            Nombre_Array (via) (P_x0) := Val;
         end if;

         Nombre_Array (via) (P_x1) := Val;

         if not P_B2 then
            Nombre_Array (via) (P_x2) := Val;
         end if;

      end Ocupar;

      entry A_Punto_De_Volar
        when A /= null
        and N_Aviones_Array (A.Aerovia) <= 3
        and not Esta_ocupado (A.Aerovia, x0, X1, X2, B0, b2)

      is
      begin

         N_Aviones_Array (A.Aerovia) := N_Aviones_Array (A.Aerovia) + 1;
         Ocupar (A.Aerovia, X0, X1, X2, B0, B2, True);

      end A_Punto_De_volar;

      Procedure Actualiza (Avion : Ptr_T_RecordAvion) is
      begin
         Computa_Zona_Posicion (Avion);
         Ocupar (Avion.Aerovia, X0, X1, X2, B0, B2, False);
         if Es_Final (Avion) then
            if N_Aviones_Array (Avion.Aerovia) > 0 then
               N_Aviones_Array (Avion.Aerovia) :=
                 N_Aviones_Array (Avion.Aerovia) - 1;
            end if;
         else
            Ocupar (Avion.Aerovia, F_X0, F_X1, F_X2, F_B0, F_B2, True);
         end if;
      end Actualiza;

      Procedure V (Avion : Ptr_T_Recordavion) is
      begin
         if (A = Avion) then
            A := null;
         end if;
      end V;

      function Es_final (Avion : Ptr_T_Recordavion) return Boolean is
         X : T_Rango_Rejilla_X := Posicion_ZonaEspacioAereo (A.Pos.x);
      begin
         if (A = Avion) then
            return
              (X <= (T_Rango_Rejilla_X'First + 1) and A.Velocidad.X < 0)
              or (X >= (T_Rango_Rejilla_X'Last - 1) and A.Velocidad.X > 0);
         end if;

         return False;
      end Es_final;

   end Ocupacion_OP;

end Pkg_Objetos_Protegidos;
