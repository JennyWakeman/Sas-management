libname examsas "\\teraetu.univ-lyon1.fr\homeetu\p1411686\My Documents\TPSAS\Exam";

data examsas.sommeil;
infile '\\teraetu.univ-lyon1.fr\homeetu\p1411686\My Documents\TPSAS\Exam\data_sommeil.csv' firstobs=2  DLM=";";
input IDEN$ AGE POIDS TAILLE ALCOOL SEXE INSOMNIE TABAC ECRAN;
run;

data examsas.sommeil;
set examsas.sommeil;
if IDEN = "ID_042" then taille=194;
run;

data examsas.sommeil;
set examsas.sommeil;
IMC = poids/(0.01*taille)^2;
if IMC >= 25 then IMC_INTERPRET = "Surpoids";
else IMC_INTERPRET = "Normal";
run;



data examsas.sommeil;
set examsas.sommeil;
pref=substr(IDEN,1,2);
suf=substr(IDEN,3,4);
if pref="id" then IDEN2="ID" ||  suf;
drop pref suf;
run;
