with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with pkg_ejercicio2;

procedure ejercicio3 is
begin
   Ada.Integer_Text_IO.Put(Item => pkg_ejercicio2.numAlumnos);

   -- 3.d) he creado una función que devuelva la variable privada
   -- Exp => 0 es quitar notación científica
   -- Aft => 1 es poner solo un decimal
   Ada.Float_Text_IO.Put(Item => pkg_ejercicio2.obtenerNota, Aft => 1, Exp => 0);
end ejercicio3;
