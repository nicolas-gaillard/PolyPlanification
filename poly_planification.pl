% Import du fichier dataset.pl
:- [datatest_timeline].
:- use_module(library(statistics)).

% ------------------
% Prédicats utiles :
% ------------------
% Création des listes
makeSeances(ListeSeances):- findall(Seance, seance(Seance), ListeSeances).

% Somme les effectifs d'une liste de groupe :
sommeEffectif([], 0).
sommeEffectif(G, Somme) :- 
	taille(G, TailleGroupe),
	Somme is TailleGroupe.
sommeEffectif([G|Gs], Somme) :- 
	sommeEffectif(Gs, Reste),
	taille(G, TailleGroupe),
	Somme is TailleGroupe + Reste.

% Vérifie que les membres d'une liste ne soient pas en conflit avec une autre :
better_intersection(List1, List2) :-
    (member(Element, List1), member(Element, List2)).

% Renvoie True s'il trouve deux éléments incompatibles
test_incompatibilite(List1, List2) :-
	(member(Element1, List1), member(Element2, List2), incompatibiliteSymetrique(Element1,Element2)).

% Renvoie la difference de plages entre deux évènements :
differencePlage(P1, J1, M1, P2, J2, M2, Result) :-
	nbPlages(TotalPlage),
	joursParMois(TotalMois),
	NbPlage1 is P1 + J1*TotalPlage + M1*TotalPlage*TotalMois,
	NbPlage2 is P2 + J2*TotalPlage + M2*TotalPlage*TotalMois,
	Result is NbPlage1 - NbPlage2.

% -------------
% Contraintes :
% -------------
% Pas de CM sur certains créneaux :
contrainteCM(Seance,Plage) :-
	\+typeSeance(Seance,cm).
contrainteCM(Seance,Plage) :-
		Plage = 2;
		Plage = 5;
		Plage = 3.

% La salle est adapté au cours :
contrainteUsage(S,R) :-
	typeSeance(S,projet).
contrainteUsage(S,R) :-
	typeSeance(S,reunion).
contrainteUsage(S,R) :-
	typeSeance(S,T),
	usageSalle(R,T).

% La salle doit être libre (aucun cours ne doit être donné dedans en même temps) :
contrainteSalleLibre(_,_,_,_,[]).
contrainteSalleLibre(Plage,Jour,Mois,Salle,Solution) :-
	\+member([_,Salle,Plage,Jour,Mois],Solution).

% La taille de la salle est suffisante pour accueillir les groupes :
contrainteTailleSalle(Seance, Salle) :- 
	taille(Salle, TailleSalle),
	findall(Groupe, assiste(Groupe, Seance), ListeGroupe),
	sommeEffectif(ListeGroupe, Total), 
	Total =< TailleSalle.

% Le ou les enseignant(s) libre(s) (ils ne donnent pas de cours à cet instant) :
contrainteEnseignant(S1,R1,P1,J1,M1, [S2,R2,P2,J2,M2]) :-
	P1\=P2,
	J1=J2,
	M1=M2;
	J1\=J2;
	M1\=M2.
contrainteEnseignant(S1,R1,P,J,M, [S2,R2,P,J,M]) :-
	findall(P1, anime(S1,P1), Ps1),
	findall(P2, anime(S2,P2), Ps2),
	\+better_intersection(Ps1, Ps2).

% Des groupe(s) incompatible(s) ne peuvent avoir cours en même temps :
/*contrainteGroupe(S1,R1,P1,J1,M1, [S2,R2,P2,J2,M2]) :-
	P1\=P2,
	J1=J2,
	M1=M2;
	J1\=J2;
	M1\=M2.*/

contrainteGroupe(S1,R1,P,J,M, [S2,R2,P,J,M]) :-
	P1=P2,
	J1=J2,
	M1=M2,
	findall(G1, assiste(G1, S1), Gs1),
	findall(G2, assiste(G2, S2), Gs2),
	\+test_incompatibilite(Gs1, Gs2).
contrainteGroupe(S1,R1,P1,J1,M1, [S2,R2,P2,J2,M2]).


% Ordonnancement des séances :
contrainteOrdonnancement(S1,P1,J1,M1,[S2,_,P2,J2,M2]):-
	\+suitSeance(S1,S2,_,_), % les 2 seances n'ont pas besoin de se suivre 
	\+suitSeance(S2,S1,_,_).
contrainteOrdonnancement(S1,P1,J1,M1,[S2,_,P2,J2,M2]):-
	suitSeance(S1,S2,X,Y),
	differencePlage(P1, J1, M1, P2, J2, M2, Result),
	between(X,Y,Result).
contrainteOrdonnancement(S1,P1,J1,M1,[S2,_,P2,J2,M2]):-
	suitSeance(S2,S1,X,Y),
	differencePlage(P2, J2, M2, P1, J1, M1, Result),
	between(X,Y,Result).

% Pas de cours les jeudi après midi :
% On considère qu'un mois complet compte 20 jours travaillés
contrainteJeudi(Jour, _) :-
	\+(0 is mod(Jour+1, 5)).

contrainteJeudi(_,Plage) :-
	Plage < 4.

% ------------------------------
% Vérification des contraintes :
% ------------------------------
verificationE(Seance,Salle,Plage,Jour,Mois,Event) :-
	contrainteEnseignant(Seance,Salle,Plage,Jour,Mois,Event),
	contrainteGroupe(Seance,Salle,Plage,Jour,Mois,Event),
	contrainteOrdonnancement(Seance,Plage,Jour,Mois,Event).
	
verificationEs(_,_,_,_,_,[]).
verificationEs(Seance,Salle,Plage,Jour,Mois, [Event|Es]) :-
	verificationE(Seance,Salle,Plage,Jour,Mois, Event),
	verificationEs(Seance,Salle,Plage,Jour,Mois ,Es).

% -------------------------
% Ecriture de la solution :
% -------------------------
ecrireSolution([]) :- 
	write("\n"),
	write("------------------------------------------------------------------ \n"),
	write("################################################################## \n"),
	write("------------------------------------------------------------------ \n"),
	write("\n").

ecrireSolution([Seance, Salle, Plage, Jour, Mois]):-
	write("Date : "),
	write("Jour numéro "),
	write(Jour),
	write(" de "),
	mois(Mois, Nom),
	write(Nom),
	write(" sur le créneau "),
	plage(Plage, T1, T2),
	write(T1),
	write(" - "),
	write(T2),
	write("\n"),
	write("Seance : "),
	write(Seance),
	write("\n"),
	typeSeance(Seance,X),
	write("Type de la séance : "),
	write(X),
	write("\n"),
	estEnseigne(Seance, Matiere),
	write("Matière : "),
	write(Matiere),
	write("\n"),
	findall(Groupe,assiste(Groupe,Seance),ListeGroupe),
	write("Groupes : "),
	write(ListeGroupe),
	write("\n"),
	findall(Enseignant,anime(Seance,Enseignant),ListeEnseignants),
	write("Enseignants : "),
	write(ListeEnseignants),
	write("\n"),
	write("Salle : "),
	write(Salle),
	write("\n"),
	write("--------------"),
	write("\n").
ecrireSolution([T|Q]):-
	ecrireSolution(T),
	ecrireSolution(Q).

indicePriorite(S, 0) :- \+ suitSeance(S,_,_,_).
indicePriorite(S, N) :- suitSeance(S, Y,_,_), indicePriorite(Y, N1), N is N1 +1.


triIndice(<, Seance1, Seance2) :- indicePriorite(Seance1, N1), indicePriorite(Seance2, N2), N1 < N2.
triIndice(>, Seance1, Seance2) :- indicePriorite(Seance1, N1), indicePriorite(Seance2, N2), N1 > N2.
triIndice(>, Seance1, Seance2) :- indicePriorite(Seance1, N1), indicePriorite(Seance2, N2), N1 = N2.

% ------------------------------
% Algorithme de plannification :
% ------------------------------
planifier([],Solution):- ecrireSolution(Solution).
planifier(ListeSeances,Solution):-

	% Choix non déterministe :
	% ------------------------
	member(Seance, ListeSeances),
	date(Jour, Mois),
	plage(Plage,_,_),
	salle(Salle),

	% Vérification des contraintes :
	% ------------------------------

	% Celles qui n'ont pas besoin de parcourir la solution :
	contrainteCM(Seance,Plage),
	contrainteJeudi(Jour,Plage),
	contrainteUsage(Seance,Salle),
	contrainteTailleSalle(Seance,Salle),
	contrainteSalleLibre(Plage,Jour,Mois,Salle,Solution),
	
	% Celles qui ont besoin de parcourir la solution :
	verificationEs(Seance,Salle,Plage,Jour,Mois,Solution),


	% Ajout de la plannification dans le résultat :
	% ---------------------------------------------
	append([ [Seance, Salle, Plage, Jour, Mois] ], Solution, Result),
	delete(ListeSeances	, Seance, ListeTronquee),

	% Appel récursif de la solution :
	% -------------------------------
	planifier(ListeTronquee, Result).
	

% #######################################################
% #######################################################

% Prédicat qui détermine la planification :
faire_planification(Solution):-
	makeSeances(ListeSeances),
	predsort(triIndice,ListeSeances,ListeTriee),
	%write(ListeTriee).
	planifier(ListeTriee,Solution).

faire_planification():-
	faire_planification([]).

% Statistiques de l'execution du prédicat :
run() :- profile(faire_planification([])).

/*suitSeanceR(Seance,Compteur,Indicateur):-
	\+suitSeance(Seance,Y,_,_);
	suitSeance(Seance,Y,_,_),
	Indicateur is Compteur 	+ 1, 
	suitSeanceR(Y,Indicateur,Z).*/


/*indicePriorite(S, 0) :- \+ suitSeance(S,_,_,_).
indicePriorite(S, N) :- suitSeance(S, Y,_,_), indicePriorite(Y, N1), N is N1 +1.


triIndice(>, indicePriorite(_,Indicateur1),indicePriorite(_,Indicateur2)) :-
        Indicateur1>Indicateur2.


triIndice(<, indicePriorite(_,Indicateur1),indicePriorite(_,Indicateur2)) :-
        Indicateur1<Indicateur2.

triIndice(=, indicePriorite(_,Indicateur1),indicePriorite(_,Indicateur2)) :-
        Indicateur1=Indicateur2.

predsort(triIndice,ListeSeances,ListeTriee).*/