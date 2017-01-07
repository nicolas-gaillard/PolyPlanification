/* ############# */
/* Base de faits */
/* ############# */

% ----------------
% Jeu de données :
% ----------------

% Enseignants 
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

% Groupe d'eleves 
groupeEleve(id4).
groupeEleve(silr1).
groupeEleve(silr2).
groupeEleve(info4).

% Salles 
/* "Prototype" : Salle(id/nom, capacite) */
salle(a1).
salle(d117).
salle(c002).
salle(d012).
salle(d004).
salle(a2).
salle(b001).

% Taille des groupes (arbitraire) et des salles 
taille(id4, 25).
taille(silr1, 25).
taille(silr2, 25).
taille(info4, 75).
taille(a1, 350).
taille(d117, 24).
taille(c002, 13).
taille(d012, 24).
taille(d004, 65).
taille(a2, 160).
taille(b001, 15).

% Type de cours (ou usages) 
typeCours(ds).
typeCours(mp).
typeCours(dsmachine).
typeCours(tp).
typeCours(reunion).
typeCours(cm).
typeCours(projet).

% Matieres 
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

/* Modélisation de la semaine 1 de cours des INFO4 */
% Seance(id)
seance(s1).
seance(s2).
seance(s3).
seance(s4).
seance(s5).
seance(s6).
seance(s7).
seance(s8). % <-- Non respect de la contrainte (CM sur créneau 6)
seance(s9).
seance(s10).
seance(s11).
seance(s12).
seance(s13).
seance(s14).
seance(s15). % <-- Non respect de la contrainte (CM sur créneau 6)
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

% Liste des créneaux 
creneau(c1).
creneau(c2).
creneau(c3).
creneau(c4).
creneau(c5).
creneau(c6).
creneau(c7).
creneau(c8).
creneau(c9).
creneau(c10).
creneau(c11).
creneau(c12).
creneau(c13).
creneau(c14).
creneau(c15).
creneau(c16).
creneau(c17).
creneau(c18).
creneau(c19).
creneau(c20).
creneau(c21).
creneau(c22).
creneau(c23).
creneau(c24).
creneau(c25).
creneau(c26).
creneau(c27).
creneau(c28).
creneau(c29).
creneau(c30).

% Plages horaire 
plage(p1, "08:00", "09:30"). 
plage(p2, "09:45", "11:00"). 
plage(p3, "11:15", "12:30").
plage(p4, "14:00", "15:30"). 
plage(p5, "15:45", "17:00"). 
plage(p6, "17:15", "18:30").

% Liste des jours travaillés 
jours(j1, "Lundi").
jours(j2, "Mardi").
jours(j3, "Mercredi").
jours(j4, "Jeudi").
jours(j5, "Vendredi").

% Mois 
mois(m1, "Janvier").
mois_jour_nf2(m1, [j1, j2, j3, j4, j5]).

mois_jour(M, J) :-
	mois_jour_nf2(M, Js),
	member(J, Js).

% Un créneau a une plage, un jour et un mois


% -------------
% Association :
% -------------

% Les associations entre les différentes relations se traduisent par des prédicats.

% Incompatibilité entre deux groupes :
estIncompatible(info, id4).
estIncompatible(info, silr1).
estIncompatible(info, silr2).
estIncompatible(info, info).
estIncompatible(id4, id4).
estIncompatible(silr1, silr1).
estIncompatible(silr2, silr2).


groupesIncompatibles(Groupe,[]).
groupesIncompatibles(Groupe,[T|Q]):-
	estIncompatible(Groupe,T),
	groupesIncompatibles(Groupe,Q).
groupesIncompatibles([X|Y],Z):-
	groupesIncompatibles(X,Z),
	groupesIncompatibles(Y,Z).


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

% Enseignant - Matière :
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

% Matière - Groupe d'élèves :
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

% Seance (id) - Type de cours :
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

/* 
 Relation sur l'ordonnancement des scéances d'une même matière suivant
 un temps d'assimilation (par défaut le nb de scéances min étant de 6 et le
 max de 24) :
*/
suitSeance(s3,s2,0,18).
suitSeance(s5,s4,0,18).
suitSeance(s7,s6,0,18).
suitSeance(s9,s8,0,18).
suitSeance(s10,s8,6,18).
suitSeance(s11,s10,0,18).
suitSeance(s13,s7,6,18).
suitSeance(s14,s13,0,18).
suitSeance(s15,s11,6,18).
suitSeance(s15,s9,6,18).
suitSeance(s19,s18,0,18).
suitSeance(s21,s20,0,18).
suitSeance(s25,s24,0,24).
suitSeance(s27,s26,0,24).
suitSeance(s28,s15,6,24).

% Seance (id) - Groupe d'élèves :
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

assiste(Groupe,[]).
assiste(Groupe,[T|Q]):-
	assiste(Groupe,T),
	assiste(Groupe,Q).


% Seance (id) - Enseignant :
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

% Seance - Matière :
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

% Contrainte de l'ordonnancement des matières :
precedeMatiere(ia,projetia).
precedeMatiere(analysedonnees,optimetaheuristiques).

% Jours travaillé - Créneau
estDans(c1,j1).
estDans(c2,j1).
estDans(c3,j1).
estDans(c4,j1).
estDans(c5,j1).
estDans(c6,j1).
estDans(c7,j2).
estDans(c8,j2).
estDans(c9,j2).
estDans(c10,j2).
estDans(c11,j2).	
estDans(c12,j2).
estDans(c13,j3).
estDans(c14,j3).
estDans(c15,j3).
estDans(c16,j3).
estDans(c17,j3).
estDans(c18,j3).
estDans(c19,j4).
estDans(c20,j4).
estDans(c21,j4).
estDans(c22,j4).
estDans(c23,j4).
estDans(c24,j4).
estDans(c25,j5).
estDans(c26,j5).
estDans(c27,j5).
estDans(c28,j5).
estDans(c29,j5).
estDans(c30,j5).

% Créneaux - plages

estPlage(c1,p1).
estPlage(c2,p2).
estPlage(c3,p3).
estPlage(c4,p4).
estPlage(c5,p5).
estPlage(c6,p6).
estPlage(c7,p1).
estPlage(c8,p2).
estPlage(c9,p3).
estPlage(c10,p4).
estPlage(c11,p5).
estPlage(c12,p6).
estPlage(c13,p1).
estPlage(c14,p2).
estPlage(c15,p3).
estPlage(c16,p4).
estPlage(c17,p5).
estPlage(c18,p6).
estPlage(c19,p1).
estPlage(c20,p2).
estPlage(c21,p3).
estPlage(c22,p4).
estPlage(c23,p5).
estPlage(c24,p6).
estPlage(c25,p1).
estPlage(c26,p2).
estPlage(c27,p3).
estPlage(c28,p4).
estPlage(c29,p5).
estPlage(c30,p6).
