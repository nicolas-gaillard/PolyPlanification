% Import du fichier dataset.pl
:- [datatest_timeline].

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

% -------------
% Contraintes :
% -------------
% Contrainte : pas de CM sur certains créneaux
contrainteCM(Seance,Plage) :-
	\+typeSeance(Seance,cm).
contrainteCM(Seance,Plage) :-
		Plage \= plage(1,_,_);
		Plage \= plage(4,_,_);
		Plage \= plage(6,_,_).

% Contrainte : la salle est adapté au cours 
contrainteUsage(S,R) :-
	typeSeance(S,projet).
contrainteUsage(S,R) :-
	typeSeance(S,reunion).
contrainteUsage(S,R) :-
	typeSeance(S,T),
	usageSalle(R,T).

contrainteSalleLibre(_,_,_,_,[]).
contrainteSalleLibre(Plage,Jour,Mois,Salle,Solution) :-
	\+member([_,Salle,Plage,Jour,Mois],Solution).

% Contrainte : la taille de la salle est suffisante 
contrainteTailleSalle(Seance, Salle) :- 
	taille(Salle, TailleSalle),
	findall(Groupe, assiste(Groupe, Seance), ListeGroupe),
	sommeEffectif(ListeGroupe, Total), 
	Total =< TailleSalle.

% Contrainte : enseignant(s) libre(s) 
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

% Contrainte : groupe(s) incompatible(s) 
contrainteGroupe(S1,R1,P1,J1,M1, [S2,R2,P2,J2,M2]) :-
	P1\=P2,
	J1=J2,
	M1=M2;
	J1\=J2;
	M1\=M2.
contrainteGroupe(S1,R1,P,J,M, [S2,R2,P,J,M]) :-
	findall(G1, assiste(G1, S1), Gs1),
	findall(G2, assiste(G2, S2), Gs2),
	\+test_incompatibilite(Gs1, Gs2).

% ------------------------------
% Vérification des contraintes :
% ------------------------------
verificationE(Seance,Salle,Plage,Jour,Mois,Event) :-
	contrainteEnseignant(Seance,Salle,Plage,Jour,Mois,Event),
	contrainteGroupe(Seance,Salle,Plage,Jour,Mois,Event).

verificationEs(_,_,_,_,_,[]).
verificationEs(Seance,Salle,Plage,Jour,Mois, [Event|Es]) :-
	verificationE(Seance,Salle,Plage,Jour,Mois, Event),
	verificationEs(Seance,Salle,Plage,Jour,Mois ,Es).

% -----------------------
% Ecrire de la solution :
% -----------------------
ecrireSolution([]).
ecrireSolution([Seance, Salle, Plage, Jour, Mois]):-
	write("Seance : "),
	write(Seance),
	write("\n"),
	typeSeance(Seance,X),
	write("Type de la séance : "),
	write(X),
	write("\n"),
	findall(Groupe,assiste(Groupe,Seance),ListeGroupe),
	write("Groupes : "),
	write(ListeGroupe),
	write("\n"),
	findall(Enseignant,anime(Seance,Enseignant),ListeEnseignants),
	write("Enseignants : "),
	write(ListeEnseignants),
	write("\n"),
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
	write("Salle : "),
	write(Salle),
	write("\n"),
	write("--------------"),
	write("\n").
ecrireSolution([T|Q]):-
	ecrireSolution(T),
	ecrireSolution(Q).

ecrireSolution2(S):-
write(S).

% ------------------------------
% Algorithme de plannification :
% ------------------------------
planifier([],Solution):- ecrireSolution(Solution).
planifier(ListeSeances,Solution):-
	member(Seance, ListeSeances),
	salle(Salle),

	date(Jour, Mois),
	plage(Plage,_,_),

	% Vérification des contraintes :
	% Celles qui n'ont pas besoin de parcourir la solution :
	%contrainteCM(Seance,Plage),
	%contrainteUsage(Seance,Salle),
	%contrainteSalleLibre(Plage,Jour,Mois,Salle,Solution),
	contrainteTailleSalle(Seance,Salle),
	
	% Celles qui ont besoin de parcourir la solution :
	verificationEs(Seance,Salle,Plage,Jour,Mois,Solution),

	% Ajout de la plannification dans le résultat :
	append([ [Seance, Salle, Plage, Jour, Mois] ], Solution, Result),
	delete(ListeSeances	, Seance, ListeTronquee),
	planifier(ListeTronquee, Result).

% --------------------------------------------------
faire_planification(Solution):-
	makeSeances(ListeSeances),
	planifier(ListeSeances,Solution).

faire_planification():-
	faire_planification([]).