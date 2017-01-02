% ####################
% .: TEST DE REGLES :.
% ####################
classroom(X) :- member(X, [a1, d117, c002, d012, d004, a2, b001]).

sont_enseignants([X]) :- enseignant(X).
sont_enseignants([X|Y]) :- enseignant(X), sont_enseignants(Y).

sont_type_cours([X]) :- typeCours(X).
sont_type_cours([X|Y]) :- typeCours(X), sont_type_cours(Y).

est_matiere(A) :- matiere(A,_,_).
est_matiere(A,_,_) :- est_matiere(A).
est_matiere(A, B, C1) :- est_matiere(A,_,_), sont_enseignants(B), sont_type_cours(C1).

member(X,[X|_]).
member(X,[_|T]):- member(X,T).

incompatibilite(info4,Y) :-
	member(Y,[silr1, silr2, id4, info4]).

incompatibilite(silr1,Y) :-
	member(Y,[info4, silr1]).

incompatibilite(silr2,Y) :-
	member(Y,[info4, silr2]).

incompatibilite(id4,Y) :-
	member(Y,[info4, id4]).

disponibiliteProf(X,Y,C1) :- 
	member(X, Y(_,_,_,_,_,C)).

disponibiliteProf(X) :- 
	enseignant(X), seance(_,_,_,[X|_],_).
