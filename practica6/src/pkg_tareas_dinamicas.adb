with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Exceptions;         use Ada.Exceptions;
with PKG_debug;              use PKG_debug;
with PKG_graficos;           use PKG_graficos;
with PKG_tipos;              use PKG_tipos;
with Ada.Calendar;           use Ada.Calendar;
with Pkg_Objetos_Protegidos; use Pkg_Objetos_Protegidos;
with Pkg_Torre_Control;      use Pkg_Torre_Control;

package body Pkg_tareas_dinamicas is

   task body T_Tarea_Avion is
      tengo_permiso_descenso  : Boolean := False;
      He_bajado               : Boolean := False;
      Tengo_Pista_asignada    : Boolean := False;
      Esta_Permiso_Aterrizaje : Boolean := False;
      Esta_En_Zona_Pista_x    : Boolean := False;
      Mi_X_Pista              : T_Coordenadax;
      procedure Imprimir is
      begin
         if Ptr_Avion /= null then
            Put_Line
              ("TASK Avion{"
               & " id ="
               & T_IdAvion'Image (Ptr_Avion.Id)
               & " pos = ("
               & T_Coordenadax'Image (Ptr_Avion.Pos.X)
               & ","
               & T_Coordenaday'Image (Ptr_Avion.Pos.Y)
               & ") "
               & " velocidad =("
               & T_RangoVelocidad'Image (Ptr_Avion.Velocidad.X)
               & ","
               & T_RangoVelocidad'Image (Ptr_Avion.Velocidad.Y)
               & ") "
               & " color ="
               & T_Color'Image (Ptr_Avion.Color)
               & " aereovia ="
               & T_Rango_Aerovia'Image (Ptr_Avion.Aerovia)
               & " aereovia_inicial ="
               & T_Rango_Aerovia'Image (Ptr_Avion.Aerovia_Inicial)
               & " pista ="
               & T_Rango_Pista'Image (Ptr_Avion.Pista)
               & " tren_aterrizaje ="
               & Boolean'Image (Ptr_Avion.Tren_Aterrizaje)
               & " }");
         end if;
      end Imprimir;

      procedure Inicio_naranja is
         antes : Time := Clock;
         ahora : Time;
      begin
         Ocupacion_Op_Global (Ptr_Avion.aerovia).Zona_Seguridad (Ptr_Avion);
         Ahora := Clock;

         if Ahora - Antes > Duration (1) then
            Ptr_Avion.Color := Orange;
         end if;
         Imprimir;
         Aparece (Ptr_Avion.all);
      end Inicio_naranja;

      procedure Seguir_Volando is
         Avanzo : Boolean := False;
      begin
         Ocupacion_Op_global (Ptr_Avion.aerovia).Actualizame
           (Ptr_Avion, Avanzo);

         if Avanzo then
            Actualiza_Movimiento (Ptr_Avion.all);
         end if;
      end Seguir_Volando;

      procedure Maniobra_Bajar_Aerovia is
      begin
         Ocupacion_Op_global (Ptr_Avion.Aerovia).desocupar (Ptr_Avion);

         Desaparece (Ptr_Avion.all);

         Ptr_Avion.Aerovia := Ptr_Avion.Aerovia + 1;
         Ptr_Avion.Velocidad.X := -1 * Ptr_Avion.Velocidad.X;
         Ptr_Avion.Pos :=
           pkg_graficos.Pos_Inicio (Ptr_Avion.Pos.x, Ptr_Avion.aerovia);

         Aparece (Ptr_Avion.all);
         Ptr_Avion.Color := Blue;

         tengo_permiso_descenso := False;
         He_Bajado := False;
      end Maniobra_Bajar_Aerovia;

      procedure Permiso_Descenso is
      begin
         select
            Tarea_Torre_Control.Permiso_Descenso
              (Ptr_Avion, tengo_permiso_descenso);

            if tengo_permiso_descenso then
               Ptr_Avion.Color := Yellow;
            end if;
         else
            null;
         end select;
      end Permiso_Descenso;

      procedure Asignar_Pista is
      begin
         select
            Tarea_Torre_Control.Asignar_Pista (Ptr_Avion.Pista);
            if Ptr_Avion.Pista = T_Rango_Pista'Last then
               Ptr_Avion.Color := Green;
            else
               Ptr_Avion.Color := red;
            end if;
            Mi_X_Pista := Pos_Inicio (Ptr_Avion.Pista).X;
         else
            null;
         end select;
      end Asignar_Pista;

      function Esta_Asignada_Pista return Boolean is
      begin
         return not (Ptr_Avion.Pista = T_Rango_Pista'First);
      end Esta_Asignada_Pista;

      procedure Permiso_Aterrizaje is
      begin
         select
            Tarea_Torre_Control.Permiso_Aterrizaje (Ptr_Avion.pista);

            Esta_Permiso_Aterrizaje := True;
            Ptr_Avion.Tren_Aterrizaje := true;
         else
            Esta_Permiso_Aterrizaje := false;
         end select;
      end Permiso_Aterrizaje;

   begin
      loop
         declare
         begin
            Inicio_Naranja;

            loop
               if tengo_permiso_descenso and Ptr_Avion.Aerovia < Num_Aerovias
               then

                  Ocupacion_Op_global (Ptr_Avion.Aerovia + 1)
                    .Hay_Hueco_Para_Bajar (Ptr_Avion, He_bajado);

                  if He_Bajado then
                     Maniobra_Bajar_Aerovia;
                  end if;
               end if;

               if not Esta_Permiso_Aterrizaje then
                  Permiso_Descenso;
               end if;

               Seguir_Volando;

               delay (RETARDO_MOVIMIENTO);

               if Ptr_Avion.Aerovia = T_Rango_Aerovia'Last then
                  if not Esta_Asignada_Pista then
                     Asignar_Pista;
                  elsif not Esta_Permiso_Aterrizaje then
                     Permiso_Aterrizaje;
                  elsif not Esta_En_Zona_Pista_x then
                     if Pkg_Objetos_Protegidos.Aux_Coinciden_En_Zonas
                          (Mi_X_Pista, Ptr_Avion.Pos.X)
                     then
                        Put_Line ("CONCIDENCIA");
                     end if;
                  end if;
               end if;

            end loop;

         exception
            when DETECTADA_POSIBLE_COLISION =>
               PKG_debug.Escribir
                 ("El avión con id "
                  & T_IdAvion'Image (Ptr_Avion.Id)
                  & " no puede despegar por colisión");
               Desaparece (Ptr_Avion.all);

            when Event : others =>
               PKG_debug.Escribir
                 ("ERROR en TASK ....: "
                  & Exception_Name (Exception_Identity (Event))
                  & " "
                  & Exception_Message (Event));
         end;

         -- if Ptr_Avion.Aerovia = T_Rango_Aerovia'Last then
         --    exit;
         -- end if;

      end loop;
   end T_Tarea_Avion;
end Pkg_tareas_dinamicas;
