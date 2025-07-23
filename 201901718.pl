% Assessment 2 Given Prolog Code.
% Has only been tested on swish prolog (web wersion of swi-prolog)
% other prolog may well not draw the pictures well.

whitebox :- format('~s', ["\u25A1"]).
space    :- format('~s', [" "]).
blackBox :- format('~s', ["\u25A0"]).

numb(0). numb(1). numb(2). numb(3). numb(4). numb(5).
numb(6). numb(7). numb(8). numb(9). numb(10). 

state([R,C]) :- numb(R),  numb(C).

showWhere(Formula) :- showRows(Formula, 0).

showRows(Formula, N) :- numb(N), !, showCols(Formula, N, 0),
                        NPlus is N + 1, showRows(Formula, NPlus).
showRows(_, _).

showCols(Formula, R, C) :- numb(C), holds(Formula, [R,C]), !, 
                           blackBox, space, CPlus is C + 1,
                           showCols(Formula, R, CPlus).

showCols(Formula, R, C) :- numb(C), !, 
                           whitebox, space, CPlus is C + 1, 
                           showCols(Formula, R, CPlus).
showCols(_, _, _) :- nl.

% holdsList is only provided as a convenience for creating 
% scenarios for testing. You should use it to test your understanding 
% of the problem and your solution.
% With no clauses for holdsList swish will complain, but we
% can get round this with the following:
% 
% holdsList(false, [ ]).
% 
% This means that the list of locations where the formula false holds 
% is the empty list.

holdsList(false, [ ]).

holds(Formula, State) :- holdsList(Formula, StateList),
                         member(State,StateList).

holds( or(P,_), S):- holds(P,S).
holds( or(_,Q), S):- holds(Q,S).

holds( and(P,Q), S) :- holds(P,S), holds(Q,S).

holds( not(P), S) :- form(P), chkstate(S), !, not(holds(P,S)).

holds( implies(P, Q), S) :- holds(or(not(P),Q),S).

holds( dia(R, F), S) :- rel(R, S, T), holds(F,T).

holds( box(R,F), S) :- foreach(rel(R,S,T),holds(F,T)).

form(bread).
form(filling).
form(or(X,Y))  :- form(X), form(Y).
form(and(X,Y)) :- form(X), form(Y).
form(implies(X,Y)) :- form(X), form(Y).
form(not(X))   :- form(X).
form(dia(_,X)) :- form(X).
form(box(_,X)) :- form(X).
form(false).

chkstate(X) :- state(X), !.
chkstate(X) :- write('unknown state : '),write(X), nl, fail. 

rel(above, [X,Y], [Z,Y]) :- numb(X), numb(Y), numb(Z), X < Z.
rel(oneabove, [X,Y], [Z,Y]) :- numb(X), numb(Y), numb(Z), Z is X + 1.

rel(below, [X,Y], [Z,Y]) :- rel(above, [Z,Y], [X,Y]).
rel(onebelow, [X,Y], [Z,Y]) :- rel(oneabove, [Z,Y], [X,Y]).

rel(isLeftOf, [X,Y], [X,Z]) :- numb(X), numb(Y), numb(Z), Y < Z.

rel(isRightOf, [X,Y], [X,Z])    :- rel(isLeftOf, [X,Z], [X,Y]).


%*********************************************************************

% Tasks and answers to 1-4
% anything logically equivalent would get full marks

%TASK 1:
%Any place that has bread cannot also have filling and no place that has filling can also have bread.

%Answers are allowed to be more than one line as long is the whole file submitted has no syntax errors.
%To answer task 1: remove the % from start of the line below and insert your answer between
%the parentheses. 
%For example, If your answer is or(bread, filling) then where it says "%answer1( )." you need
%to make it say "answer1(or(bread, filling))." and the quotes are not part of the answer.


%  - Real-world Sandwich Reference -
% https://simple.wikipedia.org/wiki/Sandwich

% In wikipedia a sandwich is defined as "a food item consisting of two or more slices of bread with one or more fillings between them".
% In a BLT for example, the sandwich is made of two slices of bread filled with bacon, lettuce and tomato. 
% Therefore, the bread and filling cannot be in the same place, as that would not be a sandwich and justified the rule that bread and filling cannot be in the same place.


% -Cultural Reflection  -
% Globally there are many different types of sandwiches, but they all have bread and filling. 
% there 'open-faced' sandwiches, e.g. Nordic, where there is only once slices of bread which holds the filling or topping.
% Exceptions such as these should be allowed, to allow for cultural differences in what a sandwich is as it allows for more flexibility in the definition of a sandwich.
% Even though sandwich was named after Earl of Sandwich, we now live in a globalised world where we should allow for cultural differences in the definition of a sandwich.
% much of UK cuisin is influenced by other cultures, e.g. Indian, Chinese, Italian, and so we should allow for cultural differences in the definition of a sandwich.

answer1(and(implies(bread, not(filling)), implies(filling, not(bread)))).

%TASK 2:
%Filling must have bread immediately above it and below it.

%Answers are allowed to be more than one line as long is the whole file submitted has no syntax errors.
%To answer task 2: remove the % from start of the line below and insert your answer between
%the parentheses. 

% Reasoned Explanation:
% Modal logic formula enforcing that filling must have nread above and below it;
% with the exception to open sandwiches. The propositional variable 'open' 
% represents open sandwich contexts (e.g., Danish smorrebrod, etc). It is vital to include this exception
% to accommodate cultural variations in sandwich definitions.
% The formula uses the 'dia' operator to express accessibility relations:
% dia(oneabove, bread) and dia(onebelow, bread) ensure that bread is directly above and below the filling.
% The 'implies' operator ensures that if the filling is present, it must be surrounded by bread.
% The 'and' operator combines the conditions, ensuring that both relations hold.
% not(open) ensures that the rule applies only to regular sandwiches, excluding open sandwiches.
% This captures the spatial structure: regular sandwiches fully enclose filling,
% while open sandwiches (culturally significant in many cuisines) are exempt.

answer2(implies(and(filling, not(open)), and(dia(oneabove, bread), dia(onebelow, bread)))).

%TASK 3:
%Going more than one row below filling there should be no bread.

%Answers are allowed to be more than one line as long is the whole file submitted has no syntax errors.
%To answer task 3: remove the % from start of the line below and insert your answer between
%the parentheses. 

% Symbolic Interpretation:
% The formula ensures there cannot be bread more than one layer below filling
% implies(filling, not(dia(onebelow, dia(onebelow,  bread)))) uses a nested diamond operator to express that if there is filling, 
% then there cannot be bread two rows below it.
% diamond operator represents the accessibility relation 
% This captures the idea that a sandwich should not have bread layers below the filling, 
% ensuring a clear separation between filling and bread.


% Real World Interpretation:
% wikipedia describes club sandwiches as having three layers of bread, with two layers of fillings, where
% each layer of filling forms a deck. However, there is a contradiction, as the filling in the first deck, will have 
% a filling below the bread, followed by another slice of bread; ie that from the second deck.
% Wikipedia: "A double decker sandwich will have three slices of bread with two layers of fillings"
% therefore the foruma doesnt cover this case. 


answer3(implies(filling, not(dia(onebelow, dia(onebelow, bread))))).


%TASK 4:
%If somewhere has filling, then everywhere which is in any row anywhere above cannot have filling.

%Answers are allowed to be more than one line as long is the whole file submitted has no syntax errors.
%To answer task 4: remove the % from start of the line below and insert your answer between
%the parentheses. 

% Modal Logic Interpretatation:
%  The formula answer4(implies(filling, not(dia(above, filling)))). captures that constrain
% that fillings cannot exist above other fillings. 
% The diamond operator ◇ (dia) represents possibility/accessibility - "there exists a reachable world."
% dia(above, filling) means it's possible to reach filling by going above.
% By negating this with not(dia(above, filling)), we ensure no filling is accessible above any filling position. 

% In spatial terms, this models the above/2 relation where above(X,Y) would indicate 
% Y is directly above X. The modal formula abstracts this into accessibility relations,
% where dia(above, ...) explores what's reachable from the 'above' relation.

% The distinction between modal forms: the formula uses ¬◇p structure 
% (not possibly p), which is stronger than ◇¬p (possibly not p). While ◇¬p would 
% mean "it's possible to not have filling above", ¬◇p means "it's not possible to have filling above" 
% suggesting absence is mandatory. This relates to □¬p (necessarily not p) since ¬◇p ≡ □¬p in modal logic.
% The ◇¬p structure would apply to optional bread scenarios (like open sandwiches),
% while the formula enforces strict filling separation.


% Real World Relevance:
% this contraint captures shows practically fillings tend to spread horizontally, ie. you wouldnt stack tomatoe on tomtao
% however, in reality, you may have filling such as tamato and lettice on top of each other, but not in the same row.
% It also captures very well ◇¬p structure (e.g., jam toast, Scandinavian open sandwich)  
% and also the standard single deck sandwhich, with one slice of bread and filling on top, which isnt a double or tripple decker.
% However, it doesnt capture the case of a club sandwich, where there is filling above the lower deck filling.
% wikipedia describes a club sandwich as "A double decker sandwich will have three slices of bread with two layers of fillings. 
% Generally one piece, is one piece of bread cut in two with a filling between each piece.... A triple decker sandwich would 
% consist of four slices of bread with three layers of fillings"

answer4(implies(filling, not(dia(above, filling)))).
  

%TASK 5
%Give three different examples of ways in which the above constraints could all be satisfied but 
%it can be argued that it is not really a sandwich. Hint: think about size of sandwiches may help.

%Your answer will be English sentences describing a problematic sandwich. 
%For example: "A sandwich that is knotted" rather than listing places which are bread and filling.
%That was just a silly example. It is unclear what a knotted sandwich would be and it is nothing like correct.

%In task 5 only (not in tasks 1 to 4) you may choose to define one or more extra relations. 
%There are no extra marks for doing this - just a possibility if you find an answer that needs it.
%Just add your relations after the ones given above.

%Answers are allowed to be more than one line as long is the whole file submitted has no syntax errors.



%ANSWER 5.1
%write your answer here as a comment, as many lines as you need but start each with the % for comments

% STRUCTURAL FLAW: The Empty Bread Sandwich
% A sandwich that has bread but no filling, e.g. a slice of bread with nothing on it.
% This violates the definition of a sandwich, as it lacks the essential filling component.
% This could be represented as a state where there is bread in a row, but no filling above or below it.

% Classification: Structural flaw or violation of the sandwich definition.

% Justification: The definition of a sandwich requires filling, and this example lacks it.
% I would therefore need a formula to suggest if there is bread, then there must be a filling above or below it

%Give a formula below that prevents your example when it holds in EVERY state.
%That is: If your formula holds everywhere than this kind of problematic sandwich cannot happen.
%Remove the % and insert your formula in the space in the next line.

answer5.1(implies(bread, or(dia(oneabove, filling), dia(onebelow, filling)))).



%ANSWER 5.2
%write your answer here as a comment, as many lines as you need but start each with the % for comments

% STRUCTURAL Flaw: The Disconnected Sandwich
% A sandwich that has bread and filling in the same row but different columns, or a donut sandwich with an empty centre.

% Classification: Structural flaw or violation of the sandwich definition.
% A donut sandwich is not a sandwich as it has an empty centre, and the bread and filling are not connected.
% This violates the definition of a sandwich, as it requires bread and filling to be connected.

% we therefore need a formula to ensure there arent empty gaps between columns of bread and/or filling

%Give a formula below that prevents your example when it holds in EVERY state.
%That is: If your formula holds everywhere than this kind of problematic sandwich cannot happen.
%Remove the % and insert your formula in the space in the next line.


answer5.2(implies(and(bread, dia(isRightOf, bread)), not(dia(isRightOf, and(not(bread), dia(isRightOf, bread)))))).


%ANSWER 5.3
%write your answer here as a comment, as many lines as you need but start each with the % for comments

% there could be vertical gaps between bread and filling, e.g. tripple decker sandwich with no filling between two decks
% which would not be a sandwich - it would disconnected multiple vertical layers of filling
%need a forumula to ensure that if there is bread above and below filling, then there must be filling in between

%Give a formula below that prevents your example when it holds in EVERY state.
%That is: If your formula holds everywhere than this kind of problematic sandwich cannot happen.
%Remove the % and insert your formula in the space in the next line.

answer5.3(implies(and(dia(oneabove, bread), dia(onebelow, bread)), filling))




% OTHER examples of problematic sandwiches that are not really sandwiches:


% CULTURAL FLAW: Halal meat with pork sandwich
% Description: A sandwich containing both halal meat and pork, violating Islamic dietary laws.

% Classification: CULTURAL violation

% Justification: This violates Islamic dietary laws (halal requirements). The presence 
% of pork (haram) contaminates the entire sandwich, making it forbidden for Muslims.
% Mixing halal and haram ingredients shows cultural insensitivity and disrespect.

% Formula to prevent mixing halal meat with pork:
answer5.4(not(and(halal, pork))).





% INGREDIENT FLAW: Ice Cream and Hot Sauce Sandwich

% Description: Vanilla ice cream with hot sauce between two bread slices.

% Classification: INGREDIENT violation 

% Justification: This combines incompatible temperatures and flavors. The cold, 
% The hot sauce's spiciness clashes with the ice cream's sweetness

% Formula to prevent this:
answer5.5(not(and(icecream, hot_sauce))).
