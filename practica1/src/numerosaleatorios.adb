with Ada.Numerics.Float_Random; with Ada.Numerics.Float_Random;
with Ada.Float_Text_IO; with Ada.Float_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

-----------------------
-- numerosAleatorios --
-----------------------

-- 6.c)
procedure numerosAleatorios is
   subtype float_rango_aleatorio is Float range 0.0 .. 1.0;
   
   generator: ada.Numerics.Float_Random.Generator;
   digito : float_rango_aleatorio;
begin
   Ada.Numerics.Float_Random.Reset(generator);
   
   loop
      digito := Ada.Numerics.Float_Random.Random(generator);
      Ada.Float_Text_IO.Put(Item => digito, Exp => 0, Fore => 0);
      Ada.text_io.skip_line;
   end loop;
end numerosAleatorios;
