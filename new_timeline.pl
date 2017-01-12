% Constantes :
joursParMois(30).
nbPlages(6).
nbMois(12).

% Plages horaire 
plage(1, "08:00", "09:30"). 
plage(2, "09:45", "11:00"). 
plage(3, "11:15", "12:30").
plage(4, "14:00", "15:30"). 
plage(5, "15:45", "17:00"). 
plage(6, "17:15", "18:30").

% Mois :
mois(1, "Janvier").
mois(2, "Février").
mois(3, "Mars").
mois(4, "Avril").
mois(5, "Mai").
mois(6, "Juin").
mois(7, "Juillet").
mois(8, "Août").
mois(9, "Septembre").
mois(10, "Octobre").
mois(11, "Novembre").
mois(12, "Décembre").

% Une date est correctement définie si elle respecte ce prédicat :
date(J,M) :-
	mois(M),
	joursParMois(JMax),
	between(1, JMax, J).

% Prédicat qui génère
/* Dans l'algo, les choix déterministes se font :

date(Jour,Mois),
plage(Plage),

Solution : [ [Seance, Salle, Plage, Jour, Mois] ]
*/

differencePlage(P1, J1, M1, P2, J2, M2, Result) :-
	nbPlages(TotalPlage),
	joursParMois(TotalMois),
	NbPlage1 is P1 + J1*TotalPlage + M1*TotalPlage*TotalMois,
	NbPlage2 is P2 + J2*TotalPlage + M2*TotalPlage*TotalMois,
	Result is NbPlage2 - NbPlage1.

% Voir question du signe : un signe - permet de dire que la séance passé en second est 