with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with pkg_ejercicio2;

procedure ejercicio1 is
   -- el error de compilación es que faltaba poner :
   s : String := "Comenzamos las prácticas de STR";
   mes : Natural;
begin
   Put("Hola Mundo!!! ");
   Put_Line(s);
   pkg_ejercicio2.otroMensaje;
   Ada.Integer_Text_IO.Get(Item => mes);
	
   case mes is
      when 1  => Put_Line("invierno");
      when 2  => Put_Line("invierno");
      when 12 => Put_Line("invierno");
      when 3  => Put_Line("primavera");
      when 4  => Put_Line("primavera");
      when 5  => Put_Line("primavera");
      when 6  => Put_Line("verano");
      when 7  => Put_Line("verano");
      when 8  => Put_Line("verano");
      when 9  => Put_Line("otoño");
      when 10 => Put_Line("otoño");
      when 11 => Put_Line("otoño");
      when others =>   Put_Line("Mes incorrecto");
   end case;


end ejercicio1;

-- 1.d) use tiene los mismos problemas que el usar el using de c++.
-- Ventaja: Escribir menos código.
-- Desventaja: Mayor colisión de nombres.
-- Por lo que muchas veces te quedas con la sintaxis más verbosa para no
--  incurrir en el problema. Esto es un downgrade respecto a lenguajes modernos
--  con módulos, donde el conflicto se resuelve adh	oc.


-- 2.b) Falla porque un archivo fuente de Ada excede en el número de unidades de
--  de compilación. Hay 2 procedimientos
