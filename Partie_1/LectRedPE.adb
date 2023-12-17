with TEXT_IO; use TEXT_IO;

-- Sauvegarder ce fichier sous le nom de: LectRedPL.adb,
-- et pour compiler, lancer: gnatmake LectRedPE.adb -o LectRedPE

-- PE : Priorité Egale

procedure LectRedPE is
   package int_io is new Integer_io(integer);
   use int_io;

   -- Interface Moniteur
   task type Moniteur is
      entry debut_lect;
      entry debut_red;
      entry fin_lect;
      entry fin_red;
      entry barriere;
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
      ouverture : Boolean := True;

   begin
      loop
         select

            -- Si le nombre de rédacteur est égal à 0, on peut lire
            when (nbRed = 0) =>
               accept debut_lect do
                  nbLect := nbLect + 1;
                  ouverture := True;
                  put_line("Lecture de X : " & Integer'Image(X));
               end debut_lect;

            or

            -- S'il y a au moins une lecture, on peut écrire
            when (nbRed + nbLect = 0) =>
               accept debut_red do
                  nbRed := nbRed + 1;
               end debut_red;

            or

            -- On met fin à la lecture
            accept fin_lect do
               nbLect := nbLect - 1;
               put_line("Fin lecture");
            end fin_lect;

            or

            -- On met fin à l'écriture
            accept fin_red do
               nbRed := nbRed - 1;
               put_line("Fin écriture");
               ouverture := True;
            end fin_red;

            or

            -- On fait la barrière
            when (fermeture = True) =>
               accept barriere do
                  ouverture := False;
               end barriere;

         end select;
      end loop;
   end Moniteur;

   -- Corps Lecteur
   task body Lecteur is
      value : Integer := 1;
   begin
      for i in 1 .. 10 loop
         M.barriere;
         M.debut_lect;
         put_line("Lecture...");
         M.fin_lect;
      end loop;
   end Lecteur;

   -- Corps Rédacteur
   task body Redacteur is
      value : Integer := 0;
   begin
      for i in 1 .. 10 loop
         M.barriere;
         M.debut_red;
         put_line("Ecriture...");
         M.fin_red;
      end loop;
   end Redacteur;

begin
   null;
end LectRedPE;
