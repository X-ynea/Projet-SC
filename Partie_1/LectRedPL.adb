

with TEXT_IO; use TEXT_IO;

procedure LectRedPL is
   package int_io is new Integer_io(integer);
   use int_io;

   -- Interface Moniteur
   task type Moniteur is
      entry debut_lect;
      entry debut_red;
      entry fin_lect;
      entry fin_red;
   end Moniteur;

   M : Moniteur;

   -- Interface Lecteur
   task type Lecteur is end Lecteur;

   -- Interface Rédacteur
   task type Redacteur is end Redacteur;

   -- Body Moniteur
   task body Moniteur is
      nbLect : Integer := 0;
      nbRed : Integer := 0;
   begin
      loop
         select

            -- S'il n'y a pas de redacteur ou de lecteur actif, on peut lire
            when (nbRed = 0) =>
               accept debut_lect do
                  nbLect := nbLect + 1;
               end debut_lect;

            or

            -- s'il n'y a pas de lecteur actifs ou en attente, on peut écrire
            when (nbLect + debut_lect'Count = 0) =>
               accept debut_red do
                  nbRed := nbRed + 1;
               end debut_red;

            or

            -- On met fin à la lecture
            accept fin_lect do
               nbLect := nbLect - 1;
            end fin_lect;

            or

            -- On met fin à la écriture
            accept fin_red do
               nbRed := nbRed - 1;
            end fin_red;

         end select;
      end loop;
   end Moniteur;

   -- corps Lecteur
   task body Lecteur is
   begin
      for i in 1 .. 10 loop
         M.debut_lect;
         M.fin_lect;
      end loop;
   end Lecteur;

   -- corps Rédacteur
   task body Redacteur is
   begin
      for i in 1 .. 10 loop
         M.debut_red;
         M.fin_red;
      end loop;
   end Redacteur;

begin
   null;
end LectRedPL;
