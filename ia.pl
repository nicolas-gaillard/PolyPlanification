/* ############# */
/* Base de faits */
/* ############# */

/* Enseignants */

Enseignant(graschia).
Enseignant(hlecapitaine).
Enseignant(mgelgon).
Enseignant(jcohen).
Enseignant(bparrein).
Enseignant(rlehn).
Enseignant(jpguedon).
Enseignant(fleman).
Enseignant(cgoncalves).
Enseignant(fbigeard).
Enseignant(pkuntz).
Enseignant(pdasilva).

/* Groupe d'eleves */

GroupeEleve(id4).
GroupeEleve(silr1).
GroupeEleve(silr2).
GroupeEleve(info4).

/* 
Si on ajoute la liste des groupes incompatibles : 
	GroupeEleve(info4, [silr1, silr2, id4]).
*/

/* Type de cours */
TypeCours(ds).
TypeCours(mp).
TypeCours(dsmachine).
TypeCours(tp).
TypeCours(reunion).
TypeCours(cm).
TypeCours(projet).
TypeCours(td). 				/* Pas de TD cette semaine mais certaines salles et matières ont des TD */

/* Salle */
/* "Prototype" : Salle(nom, capacite, [typeCours]) */
/* Remarques : */
/* 	- Les données sont issues de l'edt */
/* 	- Est ce qu'on laisse une liste d'un seul type de cours */
Salle(a1, 350, [cm, ds]).
Salle(d117, 24, [cm, tp]).
Salle(c002, 13, [tp]).
Salle(d012, 24, [tp]).
Salle(d004, 65, [cm]).
Salle(a2, 160, [cm, ds]).
Salle(b001, 15, [tp, dsmachine, mp]).

/* Matieres */
/* "Prototype" : Matiere(nom, enseignant, groupe) */

% Est ce qu'on retire les professeurs et groupe de chaque matière ? Si oui faut virer l'association.

Matiere(traitementimg, [mgelgon, jpguedon], [silr2, silr1]).
Matiere(projetia, [hlecapitaine, graschia, bparrein, fleman], [id4, silr1, silr2]).
Matiere(reseaux3, [rlehn], [silr2, silr1]).
Matiere(comptabilite, [cgoncalves], [id4]).
Matiere(ptrans, [], [id4, silr1, silr2]).
Matiere(gestionconnaissances, [fbigeard], [id4]).
Matiere(optimetaheuristiques, [pkuntz], [id4, silr1, silr2]).

/* Contrainte de l'ordonnancement des matières --> liste qui définit l'ordre des matières */
/* Exemple : [optimetaheuristiques, initiationia, projetia] */

/* Liste de tous les créneaux possibles */
/* [c1, c2, c3, c4, c5, c6] */

/* Modélisation de la semaine 1 de cours des INFO4 */
% Dans les séances, comment faire apparaitre le type et la capacité de la salle ?? 

% Seance(type, nom, groupes, enseignants, salle, creneau).
Seance(ds, traitementimg, [silr1, silr2], [jpguedon, mgelgon], a1).
Seance(tp, projetia, [id4], [hlecapitaine], d117).
Seance(tp, projetia, [id4], [hlecapitaine], d117).
Seance(tp, projetia, [silr2], [graschia], c002).
Seance(tp, projetia, [silr2], [graschia], c002).
Seance(tp, projetia, [silr1], [bparrein, fleman], d012).
Seance(tp, projetia, [silr1], [bparrein, fleman], d012).
Seance(cm, reseaux3, [silr1, silr2], [rlehn], d004). % <-- Non respect de la contrainte 

Seance(tp, reseaux3, [silr1], [bparrein, fleman], d012).
Seance(tp, reseaux3, [silr2], [rlehn, fleman], d012).
Seance(tp, reseaux3, [silr2], [rlehn, fleman], d012).
Seance(ds, comptabilite, [id4], [cgoncalves], a2).
Seance(tp, projetia, [silr1], [hlecapitaine], d117).
Seance(tp, projetia, [silr1], [hlecapitaine], d117).
Seance(cm, reseaux3, [silr1, silr2], [rlehn], d004). % <-- Non respect de la contrainte 
% Seance(projet, ptrans, [silr2, silr1, id4], [], ).
% Seance(projet, ptrans, [silr2, silr1, id4], [], ).

Seance(cm, gestionconnaissances, [id4], [fbigeard], d117).
Seance(cm, gestionconnaissances, [id4], [fbigeard], d117).
Seance(tp, projetia, [silr1], [hlecapitaine], b001).
Seance(tp, projetia, [silr1], [hlecapitaine], b001).

Seance(ds, optimetaheuristiques, [id4, silr2, silr1], [pkuntz], a2).
Seance(reunion, hyblab, [silr2, silr1], [pdasilva], a2).
Seance(tp, projetia, [silr2], [graschia], c002).
Seance(tp, projetia, [silr2], [graschia], c002).
Seance(tp, projetia, [id4], [hlecapitaine], d117).
Seance(tp, projetia, [id4], [hlecapitaine], d117).
Seance(tp, reseaux3, [silr2], [rlehn, fleman], d012).


/* .: TEST DE REGLES :. */
classroom(X) :- member(X, [a1, d117, c002, d012, d004, a2, b001]).

sont_enseignants([X|_]) :- Enseignant(X).
sont_enseignants([X|Y]) :- Enseignant(X), sont_enseignants(Y).

sont_type_cours([X|_]) :- TypeCours(X).
sont_type_cours([X|Y]) :- TypeCours(X), sont_type_cours(Y).

est_matière(A) :- Matiere(A).
est_matière(A,_,_) :- est_matière(A).
est_matiere(A, B, C) :- sont_enseignants(B), sont_type_cours(C).

member(X,[X|_]).
member(X,[_|T]):- member(X,T).