contrainteJeudi(Jour, _) :-
	\+(0 is mod(Jour+1, 5)).

contrainteJeudi(_,Plage) :-
	Plage < 4.