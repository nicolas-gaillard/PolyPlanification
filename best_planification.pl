% Import du fichier dataset.pl
:- [datatest].

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
intersection([], _).
intersection([P|_], Ps2) :-
	member(P, Ps2).
intersection([_|Ps1], Ps2) :-
	intersection(Ps1, Ps2).

better_intersection(List1, List2) :-
    (member(Element, List1), member(Element, List2)).

% Renvoie True s'il trouve deux éléments incompatibles
test_incompatibilite(List1, List2) :-
	(member(Element1, List1), member(Element2, List2), incompatibiliteSymetrique(Element1,Element2)).

% -------------
% Contraintes :
% -------------
% Contrainte : pas de CM sur certains créneaux
contrainteCM(S,C) :-
	\+typeSeance(S,cm).
contrainteCM(S,C) :-
		estPlage(C,p2);
		estPlage(C,p3);
		estPlage(C,p5).

% Contrainte : la salle est adapté au cours 
contrainteUsage(S,R) :-
	typeSeance(S,projet).
contrainteUsage(S,R) :-
	typeSeance(S,reunion).
contrainteUsage(S,R) :-
	typeSeance(S,T),
	usageSalle(R,T).

contrainteSalleLibre(_, _, []).
contrainteSalleLibre(Creneau,Salle,Solution) :-
	\+member([_,Salle,Creneau],Solution).

% Contrainte : la taille de la salle est suffisante 
contrainteTailleSalle(S, R) :- 
	taille(R, TailleSalle),
	findall(Groupe, assiste(Groupe, S), ListeGroupe),
	sommeEffectif(ListeGroupe, Total), 
	Total =< TailleSalle.

% Contrainte : enseignant(s) libre(s) 
contrainteEnseignant(S1,R1,C1, [S2,R2,C2]) :-
	C1 \= C2.
contrainteEnseignant(S1,R1,C, [S2,R2,C]) :-
	findall(P1, anime(S1,P1), Ps1),
	findall(P2, anime(S2,P2), Ps2),
	\+better_intersection(Ps1, Ps2).

% Contrainte : groupe(s) incompatible(s) 
contrainteGroupe(S1,R1,C1, [S2,R2,C2]) :-
	C1 \= C2.
contrainteGroupe(S1,R1,C, [S2,R2,C]) :-
	findall(G1, assiste(G1, S1), Gs1),
	findall(G2, assiste(G2, S2), Gs2),
	\+test_incompatibilite(Gs1, Gs2).

% ------------------------------
% Vérification des contraintes :
% ------------------------------
verificationE(Seance,Salle,Creneau,Event) :-
	%contrainteEnseignant(Seance,Salle,Creneau,Event),
	contrainteGroupe(Seance,Salle,Creneau,Event).

verificationEs(Seance,Salle,Creneau,[]).
verificationEs(Seance,Salle,Creneau, [Event|Es]) :-
	verificationE(Seance,Salle,Creneau, Event),
	verificationEs(Seance,Salle,Creneau ,Es).

% -----------------------
% Ecrire de la solution :
% -----------------------
ecrireSolution([]).
ecrireSolution(T):-
	seance(T),
	write("Seance : "),
	write(T),
	write("\n"),
	typeSeance(T,X),
	write("Type de la séance : "),
	write(X),
	write("\n"),
	findall(Groupe,assiste(Groupe,T),ListeGroupe),
	write("Groupes : "),
	write(ListeGroupe),
	write("\n"),
	findall(Enseignant,anime(T,Enseignant),ListeEnseignants),
	write("Enseignants : "),
	write(ListeEnseignants),
	write("\n");
	creneau(T),
	write("Creneau : "),
	write(T),
	write("\n");
	salle(T),
	write("Salle : "),
	write(T),
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
	creneau(Creneau),

	% Vérification des contraintes :
	% Celles qui n'ont pas besoin de parcourir la solution :
	%contrainteCM(Seance,Creneau),
	%contrainteUsage(Seance,Salle),
	%contrainteSalleLibre(Creneau,Salle,Solution),
	%contrainteTailleSalle(S,R),
	
	% Celles qui ont besoin de parcourir la solution :
	verificationEs(Seance,Salle,Creneau,Solution),

	% Ajout de la plannification dans le résultat :
	append([[Seance, Salle, Creneau]], Solution, Result),
	delete(ListeSeances	, Seance, ListeTronquee),
	planifier(ListeTronquee, Result).

% --------------------------------------------------
faire_planification(Solution):-
	makeSeances(ListeSeances),
	planifier(ListeSeances,Solution).

faire_planification():-
	faire_planification([]).