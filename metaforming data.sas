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
IMC = poids/(0.01*taille)**2;
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

proc univariate data=examsas.sommeil normaltest;
var age;
histogram / normal;
run;

proc means data=examsas.sommeil;
var ecran;
output out=examsas.STAT_ECRAN1(drop=_TYPE_ _FREQ_) mean=MOY1 std = STD1;
run;

data examsas.sommeilbis;
set examsas.sommeil;
if ecran=16 then delete;
run;

proc means data=examsas.sommeilbis;
var ecran;
output out=examsas.STAT_ECRAN2(drop=_TYPE_ _FREQ_) mean=MOY2 std = STD2;
run;


data examsas.stat_ecran;
merge examsas.STAT_ECRAN1 examsas.STAT_ECRAN2;
run;

data examsas.stat_ecran;
set examsas.stat_ecran;
rapport_std = std1/std2;
run;

proc sgplot data=examsas.sommeil;
scatter x=age y=ecran / group=insomnie;
run;

proc sort data=examsas.sommeil;
by insomnie;
run;

proc boxplot data=examsas.sommeil;
plot  age*insomnie / boxconnect=mean;
run;

proc anova data=examsas.sommeil;
class insomnie;
model age=insomnie;
run;

proc ttest data=examsas.sommeil;
var age ;
class insomnie ;
run;

/*on a utilisé 2 méthodes pour comparer les moyennes et donnent bien la meme pvalue 0.0156*/

proc freq data=examsas.sommeil order=freq;
   tables insomnie / binomial(ac wilson exact) alpha=.05;
run;

proc freq data = examsas.sommeil;
tables insomnie*tabac /chisq ;
run;

/*grosse p value donc independance*/


