with Ada.Text_IO; use Ada.Text_IO;
with pkg_ejercicio2;

procedure ejercicio1 is
   -- el error de compilación es :
   s : String := "Comenzamos las prácticas de STR";
begin
   Put("Hola Mundo!!! ");
   Put_Line(s);
   pkg_ejercicio2.otroMensaje;
end ejercicio1;

-- 1.d) use tiene los mismos problemas que el usar el using de c++.
-- Ventaja: Escribir menos código.
-- Desventaja: Mayor colisión de nombres.
-- Por lo que muchas veces te quedas con la sintaxis más verbosa para no
--  incurrir en el problema. Esto es un downgrade respecto a lenguajes modernos
--  con módulos, donde el conflicto se resuelve adhoc.


-- 2.b) Falla porque un archivo fuente de Ada excede en el número de unidades de
--  de compilación. Hay 2 procedimientos
