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

/* Remarques : */
/* 	- Ajouter liste de groupe incompatible ? */
/* 	- Ajouter groupe fils ou parent ? */

GroupeEleve(id4).
GroupeEleve(silr1).
GroupeEleve(silr2).
GroupeEleve(info4, [silr1, silr2, id4]).

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
/*	- Ecrit comme ça, il me semble que la liste est constante (hors elle peut être amené à être modifié) ? */
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
Matiere(traitementimg, [mgelgon, jpguedon], [silr2, silr1]).
Matiere(projetia, [hlecapitaine, graschia, bparrein, fleman], [id4, silr1, silr2]).
Matiere(reseaux3, [rlehn], [silr2, silr1]).
Matiere(comptabilite, [cgoncalves], [id4]).
Matiere(ptrans, [], [id4, silr1, silr2]).
Matiere(gestionconnaissances, [fbigeard], [id4]).
Matiere(optimetaheuristiques, [pkuntz], [id4, silr1, silr2]).

/* Contrainte de l'ordonnancement des matières --> liste qui définit l'ordre des matières */
/* Exemple : [optimetaheuristiques, initiationia, projetia] */
