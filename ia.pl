/* ############# */
/* Base de faits */
/* ############# */

/* Remarques :
	- Les données sont issues de l'emploie du temps et de Madoc
*/

/* Enseignants */

enseignant(graschia).
enseignant(hlecapitaine).
enseignant(mgelgon).
enseignant(jcohen).
enseignant(bparrein).
enseignant(rlehn).
enseignant(jpguedon).
enseignant(fleman).
enseignant(cgoncalves).
enseignant(fbigeard).
enseignant(pkuntz).
enseignant(pdasilva).

/* Groupe d'eleves */

groupeEleve(id4).
groupeEleve(silr1).
groupeEleve(silr2).
groupeEleve(info4).


/* Type de cours (ou Usages) */
typeCours(ds).
typeCours(mp).
typeCours(dsmachine).
typeCours(tp).
typeCours(reunion).
typeCours(cm).
typeCours(projet).

/* Salle */
/* "Prototype" : Salle(id/nom, capacite) */
salle(a1, 350).
salle(d117, 24).
salle(c002, 13).
salle(d012, 24).
salle(d004, 65).
salle(a2, 160).
salle(b001, 15).

/* Matieres */
/* "Prototype" : Matiere(nom) */

matiere(traitementimg).
matiere(projetia).
matiere(reseaux3).
matiere(comptabilite).
matiere(ptrans).
matiere(gestionconnaissances).
matiere(optimetaheuristiques).

/* Contrainte de l'ordonnancement des matières --> liste qui définit l'ordre des matières */
/* Exemple : [optimetaheuristiques, initiationia, projetia] */

/* Liste de tous les créneaux possibles */
/* [c1, c2, c3, c4, c5, c6] */

/* Modélisation de la semaine 1 de cours des INFO4 */
/* Dans les séances, comment faire apparaitre le type et la capacité de la salle ??  */

/* Seance(type, nom, groupes, enseignants, salle, creneau). */
seance(ds, traitementimg, [silr1, silr2], [jpguedon, mgelgon], a1).
seance(tp, projetia, [id4], [hlecapitaine], d117).
seance(tp, projetia, [id4], [hlecapitaine], d117).
seance(tp, projetia, [silr2], [graschia], c002).
seance(tp, projetia, [silr2], [graschia], c002).
seance(tp, projetia, [silr1], [bparrein, fleman], d012).
seance(tp, projetia, [silr1], [bparrein, fleman], d012).
seance(cm, reseaux3, [silr1, silr2], [rlehn], d004). % <-- Non respect de la contrainte 

seance(tp, reseaux3, [silr1], [bparrein, fleman], d012).
seance(tp, reseaux3, [silr2], [rlehn, fleman], d012).
seance(tp, reseaux3, [silr2], [rlehn, fleman], d012).
seance(ds, comptabilite, [id4], [cgoncalves], a2).
seance(tp, projetia, [silr1], [hlecapitaine], d117).
seance(tp, projetia, [silr1], [hlecapitaine], d117).
seance(cm, reseaux3, [silr1, silr2], [rlehn], d004). /* <-- Non respect de la contrainte */
seance(projet, ptrans, [silr2, silr1, id4], []). 
seance(projet, ptrans, [silr2, silr1, id4], []). 

seance(cm, gestionconnaissances, [id4], [fbigeard], d117).
seance(cm, gestionconnaissances, [id4], [fbigeard], d117).
seance(tp, projetia, [silr1], [hlecapitaine], b001).
seance(tp, projetia, [silr1], [hlecapitaine], b001).

seance(ds, optimetaheuristiques, [id4, silr2, silr1], [pkuntz], a2).
seance(reunion, hyblab, [silr2, silr1], [pdasilva], a2).
seance(tp, projetia, [silr2], [graschia], c002).
seance(tp, projetia, [silr2], [graschia], c002).
seance(tp, projetia, [id4], [hlecapitaine], d117).
seance(tp, projetia, [id4], [hlecapitaine], d117).
seance(tp, reseaux3, [silr2], [rlehn, fleman], d012).


% Association :
% -------------

% Les associations entre les différentes relations se traduisent par des prédicats.

% Incompatibilité entre deux groupes :
estIncompatible(info, id4).
estIncompatible(info, silr1).
estIncompatible(info, silr2).

% Usage des salles :
usageSalle(a1, cm).
usageSalle(a1, ds).
usageSalle(d117, cm).
usageSalle(d117, tp).
usageSalle(c002, tp).
usageSalle(d012, tp).
usageSalle(d004, cm).
usageSalle(a2, cm).
usageSalle(a2, ds).
usageSalle(b001, tp).
usageSalle(b001, dsmachine).
usageSalle(b001, mp).

% Enseignant - Matière 
enseigne(mgelgon, traitementimg).
enseigne(jpguedon, traitementimg).
enseigne(hlecapitaine, projetia).
enseigne(graschia, projetia).
enseigne(bparrein, projetia).
enseigne(fleman, projetia).
enseigne(rlehn, reseaux3).
enseigne(cgoncalves, comptabilite).
enseigne(fbigeard, gestionconnaissances).
enseigne(pkuntz, optimetaheuristiques).

% Matière - groupe d'élèves
etudie(silr1, traitementimg).
etudie(silr2, traitementimg).
etudie(silr1, projetia).
etudie(silr2, projetia).
etudie(id4, projetia).
etudie(info4, projetia).
etudie(silr1, reseaux3).
etudie(silr2, reseaux3).
etudie(id4, comptabilite).
etudie(silr1, ptrans).
etudie(silr2, ptrans).
etudie(id4, ptrans).
etudie(info4, ptrans).
etudie(id4, gestionconnaissances).
etudie(silr1, optimetaheuristiques).
etudie(silr2, optimetaheuristiques).
etudie(id4, optimetaheuristiques).
etudie(info4, optimetaheuristiques).

/* .: TEST DE REGLES :. */
classroom(X) :- member(X, [a1, d117, c002, d012, d004, a2, b001]).

sont_enseignants([X]) :- enseignant(X).
sont_enseignants([X|Y]) :- enseignant(X), sont_enseignants(Y).

sont_type_cours([X]) :- typeCours(X).
sont_type_cours([X|Y]) :- typeCours(X), sont_type_cours(Y).

est_matiere(A) :- matiere(A,_,_).
est_matiere(A,_,_) :- est_matiere(A).
est_matiere(A, B, C) :- est_matiere(A,_,_), sont_enseignants(B), sont_type_cours(C).

member(X,[X|_]).
member(X,[_|T]):- member(X,T).

incompatibilite(info4,Y) :-
	member(Y,[silr1, silr2, id4, info4]).

incompatibilite(silr1,Y) :-
	member(Y,[info4, silr1]).

incompatibilite(silr2,Y) :-
	member(Y,[info4, silr2]).

incompatibilite(id4,Y) :-
	member(Y,[info4, id4]).

disponibiliteProf(X,Y,C) :- 
	member(X, Y(_,_,_,_,_,C)).

disponibiliteProf(X) :- 
	enseignant(X), seance(_,_,_,[X|_],_).
