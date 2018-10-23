getSum([], 0).
getSum([H|T], N):-
			getSum(T,N1), N is N1+H.

listSum(A):-
	getSum(A, N), write(N).
