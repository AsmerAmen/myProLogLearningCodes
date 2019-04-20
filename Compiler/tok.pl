% assign_state([H|T]):-
% 	check_id(H), get_Head(T, Next, Rest),
% 	check_match(Next, "="),
% 	check_expr(Rest, Rest2), get_Head(Rest2, Next2, Rest3),
% 	check_match(Next2, ";").
	
% check_id([H|T], Ret):-
% 	is_alpha(H), print("ID "), print(H), print(" "), Ret = T.

% check_id(ID):-
% 	is_alpha(ID), print("ID "), print(ID).


% check_digit([H|T], Ret):-
% 	is_digit(H), print("Digit "), print(H), print(" "), Ret = T.

% check_digit(Digit):-
% 	is_digit(Digit), print("Digit "), print(Digit).

% check_match([H|T], ToMatch, Ret):-
% 	H == ToMatch ,print("Op "), print(H), print(" "), Ret = T.

% check_match(Op, ToMatch):-
% 	Op == ToMatch ,print("Op "), print(Op), print(" ").

% check_term(H):-
% 	check_id(H);
% 	check_digit(H).
	

% get_tail([_|T], Tail):-
% 	Tail =T.
% get_Head([H|T], Head, Tail):-
% 	Head = H, Tail =T.

% check_expr([H|T], Rest2):-
	
% 	print("7mada 2"), check_term(H), get_Head(T, Next, Rest), check_match(Next, "+"), get_Head(Rest, Next2, Rest2), check_term(Next2);	
% 	print("7mada 3"), check_term(H), get_Head(T, Next, Rest), check_match(Next, "-"), get_head(Rest, Next2, Rest2), check_term(Next2);
% 	print("7mada 1"), T==";", check_term(H), Rest2 =T.