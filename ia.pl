/* ############# */
/* Base de faits */
/* ############# */

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

/* Si on ajoute la liste des groupes incompatibles */ 




/* Type de cours */
typeCours(ds).
typeCours(mp).
typeCours(dsmachine).
typeCours(tp).
typeCours(reunion).
typeCours(cm).
typeCours(projet).
typeCours(td). 				/* Pas de TD cette semaine mais certaines salles et matières ont des TD */

/* Salle */
/* "Prototype" : Salle(nom, capacite, [typeCours]) */
/* Remarques : */
/* 	- Les données sont issues de l'edt */
/* 	- Est ce qu'on laisse une liste d'un seul type de cours */
salle(a1, 350, [cm, ds]).
salle(d117, 24, [cm, tp]).
salle(c002, 13, [tp]).
salle(d012, 24, [tp]).
salle(d004, 65, [cm]).
salle(a2, 160, [cm, ds]).
salle(b001, 15, [tp, dsmachine, mp]).

/* Matieres */
/* "Prototype" : Matiere(nom, enseignant, groupe) */

/* Est ce qu'on retire les professeurs et groupe de chaque matière ? Si oui faut virer l'association. */

matiere(traitementimg, [mgelgon, jpguedon], [silr2, silr1]).
matiere(projetia, [hlecapitaine, graschia, bparrein, fleman], [id4, silr1, silr2]).
matiere(reseaux3, [rlehn], [silr2, silr1]).
matiere(comptabilite, [cgoncalves], [id4]).
matiere(ptrans, [], [id4, silr1, silr2]).
matiere(gestionconnaissances, [fbigeard], [id4]).
matiere(optimetaheuristiques, [pkuntz], [id4, silr1, silr2]).

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


