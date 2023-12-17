
with TEXT_IO; use TEXT_IO;

-- Pour compiler lancer: gnatmake CarrGir.adb -o CarrGir

with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure CarrGir is

   package int_io is new Integer_io(integer);
   use int_io;

   nbMax : Integer := 5;  -- nombre de voiture max dans le carrefour
   subtype num_voie is Integer range 0..10;

   -- Interface carrefour
   protected type Carrefour is
      entry entrer(num_voie);
      procedure sortir;
   private
      nbVoiture : Integer := 0;  -- nombre de voiture dans le carrefour
      voie : num_voie;
      j : Integer := 0;
   end Carrefour;

   C : Carrefour;

   task type Voiture(Mess : num_voie) is end Voiture;

   -- Body Carrefour
   protected body Carrefour is

      entry entrer(for i in num_voie)
         when (i = voie and nbVoiture < nbMax) or (nbVoiture = 0) is
      begin
         nbVoiture := nbVoiture +1 ;
         voie := i;
      end entrer;

      procedure sortir is
      begin
         nbVoiture := nbVoiture -1 ;

         if nbVoiture = 0 then
            while (entrer(voie)'Count = 0) loop
               voie := (voie + 1) mod 10;
               j := j + 1;
            end loop;
         end if;
      end sortir;

   end Carrefour;

   task body Voiture is
   begin
      C.entrer(Mess);
      C.sortir;
   end Voiture;

   v1  : Voiture(1);
   v2  : Voiture(2);
   v3  : Voiture(2);
   v4  : Voiture(5);
   v5  : Voiture(5);
   v6  : Voiture(7);
   v7  : Voiture(8);
   v8  : Voiture(8);
   v9  : Voiture(8);
   v10 : Voiture(10);
   v11 : Voiture(3);
   v12 : Voiture(1);
   v13 : Voiture(3);
   v14 : Voiture(4);
   v15 : Voiture(4);

begin
   null;
end CarrGir;
