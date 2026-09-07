package pkg_ejercicio2 is
   type TdiasSemana is (Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo);
   numAlumnos: Integer := 12; -- aunque aquí es legal poner `:= 12` o mejor en la inicialización ??? -- no, es ilegal
   procedure otroMensaje;
   function obtenerNota return Float;
   
private
   notaMedia: Float  := 5.62; -- es legal no poner `:=`? es ilegal
end pkg_ejercicio2;
