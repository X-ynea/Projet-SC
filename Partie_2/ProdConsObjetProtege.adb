with TEXT_IO; use TEXT_IO;

-- Sauvegarder ce fichier sous le nom de: ProdConsObjetProtege.adb,
-- et pour compiler, lancer: gnatmake ProdConsObjetProtege.adb -o Prodconsi

-- 1 producteur, 1 consommateur, tampon de taille n

procedure ProdConsObjetProtege is
   package int_io is new Integer_io(integer);
   use int_io;

   n : Integer := 9;
   type Tampon_Type is array (0..n-1) of Integer;

   -- Interface Magasinier
   protected type Magasinier is
      entry produire(Mess : IN Integer);
      entry consommer(Mess : OUT Integer);
   private
      cpt : Integer := 0;
      tampon : Tampon_Type;
      tete, queue : Integer range 0..n-1 := 0;
   end Magasinier;

   M : Magasinier;

   -- Interface Producteur
   task type Producteur is end Producteur;

   -- Interface Consommateur
   task type Consommateur is end Consommateur;

   -- Body Magasinier
   protected body Magasinier is
      entry produire(Mess : IN Integer) when (cpt < n) is
      begin
         tampon(tete) := Mess;
         tete := (tete + 1) mod n;
         put_line("produire");
         cpt := cpt + 1;
      end produire;

      entry consommer(Mess : OUT Integer) when (cpt > 0) is
      begin
         Mess := tampon(queue);
         queue := (queue + 1) mod n;
         put_line("consommer");
         cpt := cpt - 1;
      end consommer;

   end Magasinier;

   task body Producteur is
      value : Integer := 3;
   begin
      for i in 1 .. 10 loop
         M.produire(value);
      end loop;
   end Producteur;

   task body Consommateur is
      value : Integer := 0;
   begin
      for i in 1 .. 10 loop
         M.consommer(value);
      end loop;
   end Consommateur;

begin
   null;
end ProdConsObjetProtege;
