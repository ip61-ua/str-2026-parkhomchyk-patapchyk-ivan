with Ada.Numerics.Discrete_Random;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

package body pkg_tareas_estaticas is
   task body T_Tarea is
      subtype T_Num is Integer range a..b;
      package pkg_NumAleatorio is new Ada.Numerics.Discrete_Random (T_Num);
      use pkg_NumAleatorio;
      generador_num : Generator;
      num : T_Num;
   begin
      Reset (generador_num);
      for i in 1..20 loop
         num:= Random(generador_num);
         -- Put(Item => b);
         Put(num);
         New_Line;

         -- 7.b) El sentido de comentar esta línea creo tiene algo que ver con como se imprimen los valores y más en concreto el control del programa y de los recursos.
         -- Si comentamos esta línea, lo que ocurre es que la tarea que escriba en el buffer de stdio, hace que sea más persistente. Es decir, si le toca a una tarea escribir lo hará por más tiempo seguido.
         -- Esto lo vemos porque se escribe hay series de números aleatorios del mismo tipo más seguidas. Vemos (100, 300, 434...) y luego un claro bloque de (1, 2, 5...).
         -- Lo podemos comprobar con mayor certeza y alteramos los rangos de generación, o imprimimos adicionalmente el rango de generación.
         -- Esto tiene sentido porque la tarea no tiene a ser suspendida tan seguidamente.
         delay(0.01); -- La tarea queda suspendida 0.01 segundos
      end loop;
   end T_Tarea;
begin
   -- 7.c) La pregunta se orienta a preguntar acerca de este bloque. Este bloque es opcional de un paquete. Su pricipal uso es para la inicialización de parámetros y diferentes aspectos del paquete.
   -- Por analogía es como inicalizar los valores de una clase en C++. Un ejemplo más claro sería por ejemplo que importando ese paquete, tenga que buscar un fichero en el disco que puede no estar o aparecer con diferentes nombres. Y para ello requiere cierta lógica condicional.
   -- Ejemplo real: importar dotenv en nodejs que automáticamente busque un .env. Otro: buscar un archivo de configuración Spring que puede ser un yml o json.
   -- O otro caso de uso de es comprobar la dispobilidad de algo: como nvidia cuda o no.
   -- Un caso de uso más enrevesado sería poder ejecutar código malicioso nada más al importar.
   put_line("Sentencias de inicialización del paquete");
end pkg_tareas_estaticas;
