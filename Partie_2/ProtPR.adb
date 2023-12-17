
-- gnatmake ProtPR.adb -o ProtPR

with TEXT_IO; use TEXT_IO;

procedure ProtPR is

package int_io is new Integer_IO(Integer);
use int_io;

-- Interface Moniteur

protected type Moniteur is
entry debut_lect;
procedure fin_lect;
entry debut_red;
procedure fin_red;
private
nbLect : Integer := 0;
nbRed : Integer := 0;
end Moniteur;

M : Moniteur;

-- Interface lecteur et redacteur
task type Lecteur is end Lecteur;
task type Redacteur is end Redacteur;

-- Body Moniteur
protected body Moniteur is
entry debut_lect 
when (nbRed + debut_red'Count = 0) is
begin
nbLect := nbLect + 1;
Put_Line("Debut lecture");
end debut_lect;


entry debut_red 
when (nbRed + nbLect = 0) is
begin
nbRed := nbRed + 1;
Put_Line("Debut écriture");
end debut_red;


procedure fin_lect is
begin
nbLect := nbLect - 1;
Put_Line("Fin lecture");
end fin_lect;

procedure fin_red  is
begin
nbRed := nbRed - 1;
Put_Line("Fin écriture");
end fin_red;

end Moniteur;

task body Lecteur is
value : Integer := 1;
begin
for i in 1..10 loop
M.debut_lect;
Put_Line("Lecture...");
M.fin_lect;
end loop;
end Lecteur;

task body Redacteur is
value : Integer := 0;
begin
for i in 1..10 loop
M.debut_red;
Put_Line("Ecriture...");
M.fin_red;
end loop;
end Redacteur;

L : Lecteur;
R : Redacteur;

begin
null;
end ProtPR;








