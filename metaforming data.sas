libname malib '\\teraetu.univ-lyon1.fr\homeetu\p1813127\My Documents\m2\SAS';
data malib.sommeil;
infile '\\teraetu.univ-lyon1.fr\homeetu\p1813127\My Documents\m2\SAS\data_sommeil.csv' firstobs=2  DLM=";";
input IDEN$ AGE POIDS TAILLE ALCOOL SEXE INSOMNIE TABAC ECRAN;
run;
data _NULL_;
set malib.sommeil;
where IDEN contains "id";
put IDEN;
run;

data malib.sommeil;
set malib.sommeil;
zouzou=substr(IDEN,1,2);
zouzou2=substr(IDEN,3,4);
if zouzou="id" then IDEN="ID" ||  zouzou2;
drop zouzou zouzou2;
run;
