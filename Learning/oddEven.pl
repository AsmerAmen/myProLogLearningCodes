getlength([], 0).
getlength([_|T], N):-
			getlength(T,N1), N is N1+1.


checklength(A):-
		getlength(A, N), N mod 2 =:= 0, write("Even");
		getlength(A, N), N mod 2 =:= 1, write("Odd").

