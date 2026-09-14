with Ada.Numerics.Discrete_Random; -- incluir paquete genérico predefinido
with Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

procedure ejercicio6 is
   subtype T_Digito is Integer range 0..9;
   
   -- crear instancia del paquete genérico predefinido, asignando el parámetro genérico
   package Pkg_DigitoAleatorio is new Ada.Numerics.Discrete_Random (T_Digito);
   
   generador_digito : pkg_DigitoAleatorio.Generator; -- declarar generador de valores aleatorios tipo T_Digito
   digito : T_Digito;
begin
   pkg_DigitoAleatorio.Reset (Generador_Digito); 
   -- Inicializar generador de números aleatorios
   loop
      digito := pkg_DigitoAleatorio.Random(generador_digito); -- generar número aleatorio
      Put(digito); -- 6.b) está utilizando el put de Integer_Text_Io porque si comentamos el with del Integer, no compila lol. Además el Ada.integer_text_io es una instancia especializada en integer. Dígito es un subtipo de Integer.
      skip_line;
   end loop;
end ejercicio6;
