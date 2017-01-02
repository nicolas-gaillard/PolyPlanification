/* ############# */
/* Base de faits */
/* ############# */

% ----------------
% Jeu de données :
% ----------------

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
/* "Prototype" : Matiere(id) */
matiere(traitementimg).
matiere(projetia).
matiere(reseaux3).
matiere(ia).
matiere(comptabilite).
matiere(ptrans).
matiere(gestionconnaissances).
matiere(optimetaheuristiques).
matiere(analysedonnees).

/* Liste de tous les créneaux possibles */
/* [c1, c2, c3, c4, c5, c6] */

/* Modélisation de la semaine 1 de cours des INFO4 */
/* Seance(id). */
seance(s1).
seance(s2).
seance(s3).
seance(s4).
seance(s5).
seance(s6).
seance(s7).
seance(s8). % <-- Non respect de la contrainte 
seance(s9).
seance(s10).
seance(s11).
seance(s12).
seance(s13).
seance(s14).
seance(s15). /* <-- Non respect de la contrainte */
seance(s16).
seance(s17).

seance(s18).
seance(s19).
seance(s20).
seance(s21).

seance(s22).
seance(s23).
seance(s24).
seance(s25).
seance(s26).
seance(s27).
seance(s28).

% -------------
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

% Seance (id) - type de cours 
typeSeance(s1, ds).
typeSeance(s2, tp).
typeSeance(s3, tp).
typeSeance(s4, tp).
typeSeance(s5, tp).
typeSeance(s6, tp).
typeSeance(s7, tp).
typeSeance(s8, cm).
typeSeance(s9, tp).
typeSeance(s10, tp).
typeSeance(s11, tp).
typeSeance(s12, ds).
typeSeance(s13, tp).
typeSeance(s14, tp).
typeSeance(s15, cm).
typeSeance(s16, projet).
typeSeance(s17, projet).
typeSeance(s18, cm).
typeSeance(s19, cm).
typeSeance(s20, tp).
typeSeance(s21, tp).
typeSeance(s22, ds).
typeSeance(s23, reunion).
typeSeance(s24, tp).
typeSeance(s25, tp).
typeSeance(s26, tp).
typeSeance(s27, tp).
typeSeance(s28, tp).

% Seance (id) - groupe d'élèves 
assiste(silr1,s1).
assiste(silr2,s1).
assiste(id4,s2).
assiste(id4,s3).
assiste(silr2,s4).
assiste(silr2,s5).
assiste(silr1,s6).
assiste(silr1,s7).
assiste(silr1,s8).
assiste(silr2,s8).
assiste(silr1,s9).
assiste(silr2,s10).
assiste(silr2,s11).
assiste(id4,s12).
assiste(silr1,s13).
assiste(silr1,s14).
assiste(silr1,s15).
assiste(silr1,s16).
assiste(silr2,s16).
assiste(id4,s16).
assiste(silr1,s17).
assiste(silr2,s17).
assiste(id4,s17).
assiste(id4,s18).
assiste(id4,s19).
assiste(silr1,s20).
assiste(silr1,s21).
assiste(id4,s22).
assiste(silr1,s22).
assiste(silr2,s22).
assiste(silr1,s23).
assiste(silr2,s23).
assiste(silr2,s24).
assiste(silr2,s25).
assiste(id4,s26).
assiste(id4,s27).
assiste(silr2,s28).

% Seance (id) - enseignants
anime(s1,jpguedon).
anime(s1,mgelgon).
anime(s2,hlecapitaine).
anime(s3,hlecapitaine).
anime(s4,graschia).
anime(s5,graschia).
anime(s6,bparrein).
anime(s6,fleman).
anime(s7,bparrein).
anime(s7,fleman).
anime(s8,rlehn).
anime(s9,bparrein).
anime(s9,fleman).
anime(s10,rlehn).
anime(s10,fleman).
anime(s11,rlehn).
anime(s11,fleman).
anime(s12,cgoncalves).
anime(s13,hlecapitaine).
anime(s14,hlecapitaine).
anime(s15,rlehn).
anime(s18,fbigeard).
anime(s19,fbigeard).
anime(s20,hlecapitaine).
anime(s21,hlecapitaine).
anime(s22,pkuntz).
anime(s23,pdasilva).
anime(s24,graschia).
anime(s25,graschia).
anime(s26,hlecapitaine).
anime(s27,hlecapitaine).
anime(s28,rlehn).
anime(s28,fleman).

% Seance - matière 
estEnseigne(s1, traitementimg).
estEnseigne(s2, projetia).
estEnseigne(s3, projetia).
estEnseigne(s4, projetia).
estEnseigne(s5, projetia).
estEnseigne(s6, projetia).
estEnseigne(s7, projetia).
estEnseigne(s8, reseaux3).
estEnseigne(s9, reseaux3).
estEnseigne(s10, reseaux3).
estEnseigne(s11, reseaux3).
estEnseigne(s12, comptabilite).
estEnseigne(s13, projetia).
estEnseigne(s14, projetia).
estEnseigne(s15, reseaux3).
estEnseigne(s16, ptrans).
estEnseigne(s17, ptrans).
estEnseigne(s18, gestionconnaissances).
estEnseigne(s19, gestionconnaissances).
estEnseigne(s20, projetia).
estEnseigne(s21, projetia).
estEnseigne(s22, optimetaheuristiques).
estEnseigne(s23, hyblab).
estEnseigne(s24, projetia).
estEnseigne(s25, projetia).
estEnseigne(s26, projetia).
estEnseigne(s27, projetia).
estEnseigne(s28, reseaux3).

% Contrainte de l'ordonnancement des matières 
precede(ia,projetia).
precede(analysedonnees,optimetaheuristiques).

% ####################
% .: TEST DE REGLES :.
% ####################
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
