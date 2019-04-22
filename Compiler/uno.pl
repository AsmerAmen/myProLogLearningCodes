% Author : Asmer Amen
% Compiled with SWI-prolog
% Exmples:	main("x = x + 5 ;").  
			% main("x = 5 ;").
			% main("x = 5 ; x = x + 5 ;").
			% main("if ( x == 5 ) x = 6 ; else { x = 3 ; }").
			% main("if ( x == 5 ) { x = 6 ; x = x + 5 ; } else { x = 3 ; }").
			% main("for ( x = 0 ; x < 5 ; x = x + 1 ) { y = x ; }").

main(S):-
  split_string(S, " ", "", Tokens), parse(Tokens).

parse(Tokens):-
  op_state(Tokens, _).

op_state([], []).
op_state(S, RET):-
  statement(S, Rest), nl, op_state(Rest, RET);
  statement(S, Rest), RET = Rest.

statement(S, Return):-
	for_state(S, Return);
	if_state(S, Return);
	assign_state(S, Return).
	

if_state(S, RET):-
	nl,
	get_Head(S, Next, Rest), check_match(Next, "if"),
	get_Head(Rest, Next2, Rest2), check_match(Next2, "("), 
 	check_cond(Rest2, Rest3),
	get_Head(Rest3, Next4, Rest4), check_match(Next4, ")"),
	get_Head(Rest4, Next5, Rest5), check_match(Next5, "{"),
	op_state(Rest5, Rest6),
	get_Head(Rest6, Next7, Rest7), check_match(Next7, "}"), 
	if_state_rest(Rest7, Rest8), RET = Rest8;

	get_Head(S, Next, Rest), check_match(Next, "if"),
	get_Head(Rest, Next2, Rest2), check_match(Next2, "("), 
 	check_cond(Rest2, Rest3),
	get_Head(Rest3, Next4, Rest4), check_match(Next4, ")"),
	statement(Rest4, Rest5),
	if_state_rest(Rest5, Rest6), RET = Rest6.

if_state_rest(S, RET):-
	nl,
	get_Head(S, Next, Rest), check_match(Next, "else"),
	get_Head(Rest, Next2, Rest2), check_match(Next2, "{"),
	op_state(Rest2, Rest3),
	get_Head(Rest3, Next4, Rest4), check_match(Next4, "}"),
	RET = Rest4;
	
	get_Head(S, Next, Rest), check_match(Next, "else"),
	statement(Rest, Rest2), RET = Rest2;

	RET = S.

doWhile_state(S, RET):- !.

for_state(S, RET):-
	nl,
	get_Head(S, Next, Rest), check_match(Next, "for"),
	get_Head(Rest, Next2, Rest2), check_match(Next2, "("), 
	for_assign_state(Rest2, Rest3),
	get_Head(Rest3, Next4, Rest4), check_match(Next4, ";"),
	check_cond(Rest4, Rest5),
	get_Head(Rest5, Next6, Rest6), check_match(Next6, ";"),
	for_assign_state(Rest6, Rest7),
	get_Head(Rest7, Next8, Rest8), check_match(Next8, ")"),
	get_Head(Rest8, Next9, Rest9), check_match(Next9, "{"),
	op_state(Rest9, Rest10),
	get_Head(Rest10, Next11, Rest11), check_match(Next11, "}"),
	RET = Rest11.




for_assign_state([H|T], Rest2):-
	check_id(H), get_Head(T, Next, Rest),
	check_match(Next, "="),
	check_expr(Rest, Rest2).

assign_state([H|T], Rest3):-
	check_id(H), get_Head(T, Next, Rest),
	check_match(Next, "="),
	check_expr(Rest, Rest2), get_Head(Rest2, Next2, Rest3),
	check_match(Next2, ";").
	
% check_id([H|T], Ret):-
% 	is_alpha(H), print("ID "), print(H), print(" "), Ret = T.

check_id(ID):-
	is_alpha(ID), print("ID "), print(ID).


% check_digit([H|T], Ret):-
% 	is_digit(H), print("Digit "), print(H), print(" "), Ret = T.

check_digit(Digit):-
	is_digit(Digit), print("Digit "), print(Digit).

% check_match([H|T], ToMatch, Ret):-
% 	H == ToMatch ,print("Op "), print(H), print(" "), Ret = T.

check_match(Op, ToMatch):-
	Op == ToMatch ,print("Op "), print(Op), print(" ").


check_term(H):-
	check_id(H);
	check_digit(H).
	
check_term(S, RET):-
	check_factor(S, RET).

check_factor([H| T], RET):-
	check_id(H), RET = T;
	check_digit(H), RET = T;
	check_match(H, "("),
	check_expr(T, Rest),
	get_Head(Rest, Next2, Rest2), check_match(Next2, ")"),
	RET = Rest2.



get_tail([_|T], Tail):-
	Tail =T.
get_Head([H|T], Head, Tail):-
	Head = H, Tail =T.

check_expr(S, RET):-
	check_term(S, Rest), RET = Rest;
	get_Head(S, Head, Rest), get_Head(Rest, Head2, _), Head2==";", check_term(Head), RET =Rest;
	check_term(S, Rest), get_Head(Rest, Next2, Rest2), check_match(Next2, "+"), check_term(Rest2, Rest3), RET= Rest3;	
	check_term(S, Rest), get_Head(Rest, Next2, Rest2), check_match(Next2, "-"), check_term(Rest2, Rest3), RET = Rest3.
	
check_cond([H|T], RET):-
	check_id(H), get_Head(T, Next, Rest), check_relOp(Next), check_expr(Rest, RET).

check_relOp(Op):-
	member(Op, ["<", ">", "<=", ">=", "==", "!="]), print("rel Op "), print(Op), print(" ").

check_logicOp(Op):-
	member(Op, ["&", "&&", "|", "||"]).
	