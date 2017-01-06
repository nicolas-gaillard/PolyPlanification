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

% ------------------------------
% Algorithme de plannification :
% ------------------------------
planifier([],Solution) :- write(Solution).
planifier(ListeSeances,Solution):-
	member(S, ListeSeances),
	salle(Room),
	creneau(C),

	% Contraintes : 


	% Ajout de la plannification dans le résultat :
	append([[S, Room, C]], Solution, Result),
	delete(ListeSeances, S, ListeTronquee),
	planifier(ListeTronquee, Result).

% --------------------------------------------------

faire_planification(Solution):-
	makeSeances(ListeSeances),
	planifier(ListeSeances,Solution).

