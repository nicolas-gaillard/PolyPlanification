% Import du fichier dataset.pl
:- [datatest].

% Création des listes
makeSeances(ListeSeances):- findall(Seance, seance(Seance), ListeSeances).

% -------------
% Contraintes :
% -------------

contrainteCM(S,C) :-
	\+typeSeance(S,cm); 
	(	
		estPlage(C,p2);
		estPlage(C,p3);
		estPlage(C,p5)
	).

contrainteUsage(S,R) :-
	\+typeSeance(S,projet);
	\+typeSeance(S,reunion);
	typeSeance(S,T),
	usageSalle(R,T).

contrainteSalleLibre(C,R,Solution) :-
	\+member([_,R,C],Solution).

% Contrainte : enseignant(s) libre(s) :
intersectionProf([P|_], Ps2) :-
	member(P, Ps2).
intersectionProf([_|Ps1], Ps2) :-
	intersectionProf(Ps1, Ps2).

contrainteEnseignant(S1,C1,R1, [S2,C2,R2]) :-
	C1 \= C2.
contrainteEnseignant([S1,C1,R1], [S2,C2,R2]) :-
	findall(P1, anime(S1,P1), Ps1),
	findall(P2, anime(S2,P2), Ps2),
	\+intersectionProf(Ps1, Ps2).

% ------------------------------
% Vérification des contraintes :
% ------------------------------
verificationE(S,C,R,Event) :-
	contrainteEnseignant(S,C,R,Event).

verificationEs(S,C,R,[]).
verificationEs(S,C,R, [Event|Es]) :-
	verificationE(S,C,R, Event),
	verificationEs(S,C,R,Es).

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
	member(S, ListeSeances),
	salle(Room),
	creneau(C),


	% Vérification des contraintes :
	contrainteCM(S,C),
	contrainteUsage(S,R),
	contrainteSalleLibre(C,R,Solution),
	verificationEs(S,C,R,Solution),

	% Ajout de la plannification dans le résultat :
	append([[S, Room, C]], Solution, Result),
	delete(ListeSeances	, S, ListeTronquee),
	planifier(ListeTronquee, Result).

% --------------------------------------------------
faire_planification(Solution):-
	makeSeances(ListeSeances),
	planifier(ListeSeances,Solution).

faire_planification():-
	faire_planification([]).