% Import du fichier dataset.pl
:- [dataset].

% ------------------
% Prédicats utiles :
% ------------------

% Vérification d'un élément dans une liste 
member(H, [H|T]).
member(H, [X|T]) :- member(H, T).

% Création des listes
makeSeances(ListeSeances):- findall(Seance, seance(Seance), ListeSeances).
% makeCreneaux(ListeCreneaux):- findall(Creneaux, creneau(Creneaux), ListeCreneaux).
% makeSalle(ListeSalles):- findall(Salle, salle(Salle), ListeSalles).

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


contrainteSalleLibre(C,R,[]).
contrainteSalleLibre(C,R,Solution) :-
	\+member([_,R,C],Solution).




% ------------------------------
% Algorithme de plannification :
% ------------------------------
planifier([],Solution) :- write(Solution).
planifier(ListeSeances,Solution):-
	member(S, ListeSeances),
	salle(Room),
	creneau(C),

	% Contraintes : 
	contrainteCM(S,C),
	contrainteUsage(S,Room),
	contrainteSalleLibre(C,R,Solution),



	% Ajout de la plannification dans le résultat :
	append([[S, Room, C]], Solution, Result),
	delete(ListeSeances	, S, ListeTronquee),
	planifier(ListeTronquee, Result).

% --------------------------------------------------

faire_planification(Solution):-
	makeSeances(ListeSeances),
	planifier(ListeSeances,Solution).

