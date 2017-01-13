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
enseignant(fpicarougne).
enseignant(srouibia).
enseignant(amilliat).
enseignant(mbarkowsky).
enseignant(yprie).
enseignant(graschia).
enseignant(mpnachouki).
enseignant(vricordel).
enseignant(jmartinez).
enseignant(sporcheron).
enseignant(loili).
enseignant(apigeau).
enseignant(cgoncalves).
enseignant(jmoreau).
enseignant(profAnglais).
enseignant(profPtrans).

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
salle(gymnase).
salle(projet).
salle(anglais).
salle(nautilus).

% Taille des groupes (arbitraire) et des salles 
taille(id4, 25).
taille(silr1, 25).
taille(silr2, 25).
taille(info4, 75).
taille(a1, 350).
taille(d117, 30). % Anciennement 24
taille(c002, 13).
taille(d012, 30). % Anciennement 24
taille(d004, 65).
taille(a2, 160).
taille(b001, 15).
taille(gymnase, 500).
taille(projet,150).
taille(anglais,150).
taille(nautilus,150).

% Type de cours (ou usages) 
typeCours(ds).
typeCours(mp).
typeCours(dsmachine).
typeCours(tp).
typeCours(reunion).
typeCours(cm).
typeCours(projet).
typeCours(sport).
typeCours(anglais).

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
matiere(multimedia).
matiere(cpp).
matiere(bdd).
matiere(genieLogiciel).
matiere(gestionProjet).
matiere(modeleAleatoire).
matiere(progPara).
matiere(analDonnees).
matiere(anglais).
matiere(sport).
matiere(marketing).
matiere(patrons).
matiere(simulation).

/* Modélisation de la semaine 1 de cours des INFO4 */
% Seance(id)
/*seance(s1).
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
seance(s28).*/
% Dates :
% -------

% Constantes :
joursParMois(20).
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
	mois(M,_),
	joursParMois(JMax),
	between(1, JMax, J).


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

incompatibiliteSymetrique(X,Y):- % évite la boucle infinie 
	estIncompatible(X,Y);
	estIncompatible(Y,X).

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
usageSalle(gymnase,sport).
usageSalle(projet,ptrans).
usageSalle(anglais,anglais).
usageSalle(nautilus,td).
usageSalle(nautilus,cm).

% Enseignant - Matière :
/*enseigne(mgelgon, traitementimg).
enseigne(jpguedon, traitementimg).
enseigne(hlecapitaine, projetia).
enseigne(graschia, projetia).
enseigne(bparrein, projetia).
enseigne(fleman, projetia).
enseigne(rlehn, reseaux3).
enseigne(cgoncalves, comptabilite).
enseigne(fbigeard, gestionconnaissances).
enseigne(pkuntz, optimetaheuristiques).*/

% Matière - Groupe d'élèves :
/*etudie(silr1, traitementimg).
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
etudie(info4, optimetaheuristiques).*/

% Seance (id) - Type de cours :
/*typeSeance(s1, ds).
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
typeSeance(s28, tp).*/

/* 
 Relation sur l'ordonnancement des scéances d'une même matière suivant
 un temps d'assimilation (par défaut le nb de scéances min étant de 6 et le
 max de 24) :
*/

suitSeance(s1,s6,6,18).
suitSeance(s6,s7,6,18).
suitSeance(s7,s3,6,18).
suitSeance(s3,s2,6,18).
suitSeance(s5,s4,0,18).
suitSeance(s9,s8,0,18).
suitSeance(s10,s8,6,18).
uitSeance(s11,s10,0,18).
suitSeance(s13,s7,6,18).
suitSeance(s14,s13,0,18).
suitSeance(s15,s9,6,18).
suitSeance(s19,s18,0,18).
suitSeance(s21,s20,0,18).
suitSeance(s25,s24,0,24).
suitSeance(s27,s26,0,24).
suitSeance(s28,s15,6,24).

% Seance (id) - Groupe d'élèves :
/*assiste(silr1,s1).
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
assiste(silr2,s28).*/
% :-dynamic(assiste/2).

assistent(Groupe,[]).
assistent(Groupe,[T|Q]):-
	assiste(Groupe,T),
	assistent(Groupe,Q).

/*assistent([],Groupe).
assistent([X|Y],Groupe):-
	assiste(X,Groupe),
	assistent(Y,Groupe).*/



% Seance (id) - Enseignant :
/*anime(s1,jpguedon).
anime(s1,mgelgon).
anime(s1,hlecapitaine).
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
anime(s28,fleman).*/

/*anime(Seance,[]).
anime(Seance,[X,Y]):-
	anime(Seance,X),
	anime(Seance,Y).*/



% Seance - Matière :
/*estEnseigne(s1, traitementimg).
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
estEnseigne(s28, reseaux3).*/

% Contrainte de l'ordonnancement des matières :
precedeMatiere(projetia,traitementimg).
precedeMatiere(ia,projetia).
precedeMatiere(analysedonnees,optimetaheuristiques).




seances(multimedia, cm, [id4], [jpguedon],
	[s1,s6,s29,s63,s64]).
seances(multimedia, tp, [id4], [mgelgon],
	[s43]).


seances(cpp, cm, [id4,silr1,silr2], [fpicarougne],
	[s2,s17,s27,s36,s54,s58]).
seances(cpp, tp, [id4], [srouibia],
	[s57]).
seances(cpp, tp, [silr1], [amilliat],
	[s61]).
seances(cpp, tp, [silr2], [amilliat],
	[s65]).


seances(genieLogiciel, cm, [id4,silr1,silr2], [mbarkowsky],
	[s3,s4,s25,s37,s45,s52]).
seances(genieLogiciel, cm, [id4,silr1,silr2], [yprie],
	[s5,s7]).
seances(genieLogiciel, td, [silr2], [yprie], 
	[s8]).
seances(genieLogiciel, td, [silr1], [yprie], 
	[s12]).
seances(genieLogiciel, td, [id4], [yprie], 
	[s18]).


seances(bdd, cm, [id4,silr1,silr2], [graschia],
	[s9,s21,s30,s35,s62]).
seances(bdd,td,[silr1], [mpnachouki],
	[s34,s76]).
seances(bdd,td,[silr2], [mpnachouki],
	[s39,s70]).
seances(bdd,td,[id4], [graschia],
	[s41,s72]).
seances(bdd,tp,[id4], [graschia],
	[s46,s47]).


seances(modeleAleatoire, cm, [silr1,silr2], [vricordel],
	[s10,s13,s19,s28]).
seances(modeleAleatoire, td, [silr1], [vricordel],
	[s15, s31]).
seances(modeleAleatoire, td, [silr2], [bparrein],
	[s16,s32]).


seances(progPara, cm, [id4], [jmartinez], 
	[s11,s14]).
seances(progPara, td, [id4], [jmartinez], 
	[s26,s33]).
/*seances(progPara, td, [id4], [jmartinez], 
	[s26,s33]).*/
seances(progPara, ds, [id4], [jmartinez], 
	[s69]).


seances(analDonnees, cm, [id4], [pkuntz],
	[s20,s22,s38,s53,s60,s73]).


seances(ptrans, cm, [id4,silr1,silr2], [jpguedon],
	[s23]).
seances(ptrans, cm, [id4,silr1,silr2], [mbarkowsky],
	[s24]).


seances(gestionProjet, td, [id4], [sporcheron],
	[s40]).
seances(gestionProjet, td, [silr1], [sporcheron],
	[s42]).
seances(gestionProjet, td, [silr1], [sporcheron],
	[s44]).


seances(marketing, cm, [silr1,silr2], [loili],
	[s48,s49,s74,s75]).
seances(marketing, td, [id4], [loili],
	[s50,s51,s77,s78]).


seances(patrons,cm, [id4,silr1,silr2], [apigeau],
	[s55,s66,s71]).


seances(anglais,anglais, [id4,silr1,silr2], [profAnglais],
	[s56]).


seances(sport,sport, [id4,silr1,silr2], [profSport],
	[s59]).


seances(ptrans,ptrans, [id4,silr1,silr2], [profPtrans],
	[s67,s68]).

% Les options (Espagnol, Anglais Renforcé) ne sont pas présentes ainsi que les cours de Français
% Les tiers temps ne sont pas comptabilisés


/*:-dynamic(anime/2).
:-dynamic(seance/1).
:-dynamic(estEnseigne/2).
:-dynamic(anime/2).
:-dynamic(anime/2).
:-dynamic(anime/2).*/

:-dynamic(seance/1).
:-dynamic(estEnseigne/2).
:-dynamic(anime/2).
:-dynamic(enseigne/2).
:-dynamic(etudie/2).
:-dynamic(assiste/2).
:-dynamic(typeSeance/2).




creerSeances(Matiere,Type,Groupes,Profs,[]).
creerSeances(Matiere, Type,Groupes, Profs, [Seance|Y]):-
	assertz(seance(Seance)),
	assertz(estEnseigne(Seance,Matiere)),
	forall(member(Prof, Profs),
		(
			enseigne(Prof,Matiere),
			assertz(anime(Seance, Prof));
			assertz(anime(Seance, Prof)),
			assertz(enseigne(Prof,Matiere)) % merde
		)
	),	
	forall(member(Groupe, Groupes),
		(
			etudie(Groupe,Matiere),
			assertz(assiste(Groupe, Seance));
			assertz(assiste(Groupe, Seance)),
			assertz(etudie(Groupe, Matiere)) % merde
		)
	),
	assertz(typeSeance(Seance,Type)),
	creerSeances(Matiere,Type,Groupes, Profs,Y).


:- forall(
    seances(Matiere,Type,Groupes,Profs,Seances),
    (
        creerSeances(Matiere,Type,Groupes,Profs,Seances)
    )
).


/*calculIndicateur(Seance,Result):-
	suitSeance(Seance,Y)

priorite(Seance,Indicateur):-
	suitSeance(Seance,Y),
	aggregate_all(count, suitSeance(Seance,Y), Count).*/