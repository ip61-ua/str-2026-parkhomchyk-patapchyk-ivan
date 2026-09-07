with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with pkg_ejercicio2;
with Ada.Text_IO;

procedure ejercicio3 is
   package Dias_IO is new
     Ada.Text_IO.Enumeration_IO (Enum => pkg_ejercicio2.TdiasSemana);

   e : pkg_ejercicio2.Tdiassemana;
begin
   Ada.Integer_Text_IO.Put (Item => pkg_ejercicio2.numAlumnos);

   -- 3.d) he creado una función que devuelva la variable privada
   -- Exp => 0 es quitar notación científica
   -- Aft => 1 es poner solo un decimal
   Ada.Float_Text_IO.Put
     (Item => pkg_ejercicio2.obtenerNota, Aft => 1, Exp => 0);
	  
   Ada.Text_Io.New_Line;
		
   -- 4.b) No funca porque es de otro paquete. Falta use o espacio de nombres.
   --   Put no es visible! No sabemos a cual nos referimos.

   -- 4.c) No hay declarar dia porque así es el bucle.
   for dia in pkg_ejercicio2.TdiasSemana loop
      Dias_IO.Put (dia);
      Ada.Text_IO.New_Line;
   end loop;

   Ada.Text_Io.Put_Line ("Introduzca por teclado un día cualquiera: ");	
   Dias_IO.Get(Item => e);
		
   -- 4.e)	 Peta!
   
   case e is
      when pkg_ejercicio2.Lunes => Ada.Text_IO.Put_Line("El Lunes hay clases de STR");
      when others => Ada.Text_IO.Put("El ");
         Dias_IO.Put(Item => e);
         Ada.Text_IO.Put_Line(" no hay clases de STR");
   end case;										    
	-----------------------------------------------------------------------------------------------
						
end ejercicio3;
