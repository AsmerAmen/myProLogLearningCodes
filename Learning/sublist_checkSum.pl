getSum([], 0).
getSum([H|T], Sum):-
			getSum(T,N1), Sum is N1+H.

conc([],L,L).
   conc([H|T],L2,[H|L3])  :-  conc(T,L2,L3). 

sublist(S,L):-conc(_ , L2, L), conc(S, _, L2).


subListCheck(List, Num):-
	sublist(SubList,List), getSum(SubList, Sum), Sum is Num, write(SubList).
	