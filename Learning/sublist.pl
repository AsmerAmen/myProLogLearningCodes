conc([],L,L).
conc([H|T],L2,[H|L3])  :-  conc(T,L2,L3). 

sublist(S,L):-conc(_ , L2, L), conc(S, _, L2).