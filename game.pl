:- dynamic i_am_at/1, shia/1, leg/1.   /* Needed by SWI-Prolog. */
:- retractall(shia( _)), retractall(i_am_at(_)), retractall(leg(_)).

i_am_at(woods).
shia(alive).
leg(fine).




what_to_do('run.',woods).
what_to_do('ask_for_autograph.',woods).
what_to_do('run_for_your_life.',further_down).
what_to_do('fight.',further_down).
what_to_do('look_around.',far_away).
what_to_do('gnaw.',trap).
what_to_do('scream_for_help.',trap).
what_to_do('kill.',small_cottage).
what_to_do('get_back.',small_cottage).


path(woods,further_down).
path(woods,shia_autograph).
path(further_down,far_away).
path(far_away,trap).
path(trap,small_cottage).
path(far_away,small_cottage).
path(small_cottage,fighting_scene).

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        write('You can:'), nl,
        possible_actions(Place),
        nl.



possible_actions(Place) :-
		what_to_do(X,Place),
		write('		'),write(X), nl,
		false.

run :-
		i_am_at(woods),
        path(woods, further_down),
        retract(i_am_at(_X)),
        assert(i_am_at(further_down)),
        look, !.
run_for_your_life :-
		i_am_at(further_down),
        path(further_down, far_away),
        retract(i_am_at(_X)),
        assert(i_am_at(far_away)),
        look, !.
ask_for_autograph :-
		i_am_at(woods),
        path(woods, shia_autograph),
        retract(i_am_at(_X)),
        assert(i_am_at(shia_autograph)),
        look, !.
fight :-
		i_am_at(further_down),
        write('You guess since you know Jis Jitsu'), nl,
        write('you can take on Shia LaBeouf armed'), nl,
        write('with a knife.'), nl,
        write('You guessed wrong.'), nl,
        !, die.

look_around :-
		i_am_at(far_away),
		write('Stranded with a murderer'),nl,
		write('you creep silently through the underbrush'),nl,
		write('Aha! In the distance'),nl,
		write('A small cottage with a light on'),nl,
		write('You can:'), nl,
		write('		move_stealthly.'), nl,
		write('		move_cautiously.'), nl.

move_stealthly :-
		i_am_at(far_away),
        path(far_away, trap),
        retract(i_am_at(_X)),
        assert(i_am_at(trap)),
        look, !.

move_cautiously :-
		i_am_at(far_away),
		write('Hope! You move cautiously toward it,'),nl,
		write('constatnly looking around.'),nl,
		path(far_away, small_cottage),
        retract(i_am_at(_X)),
        assert(i_am_at(small_cottage)),
		look, !.

gnaw :-
		i_am_at(trap),
		write('Gnawing off your leg (Quiet, quiet)'),nl,
		write('Limping to the cottage (Quiet, quiet)'),nl,
		write('You can:'), nl,
		write('		limp_on.'), nl.

limp_on :-
		i_am_at(trap),
		leg(cut_off),
		path(trap, small_cottage),
        retract(i_am_at(_X)),
        assert(i_am_at(small_cottage)),
        look, !.

get_back :-
		i_am_at(small_cottage),
		leg(fine),
		shia(alive),
		write('Through some kind of miracle you'),nl,
		write('managed to slip past him and get away.'),nl,
		nl,
		write('Later...'),nl,
		write('On TV:'),nl,
		write('''There have been another person missing in the woods'''),nl,
		write('Although you feel bad, you know no one would ever belive you'),nl,
		write('especially after anonymous letter told the police to search'),nl,
		write('the cottage.'),nl,
		write('The Police have found nothing...'),nl,
		nl,
		nl, 
		write('Congratulations you have beaten the game!'),nl,
		write('There may be another ending!'),nl,
		!, die.
get_back :-
		i_am_at(small_cottage),
		leg(cut_off),
		shia(alive),
		write('You try to slip past him when, because'),nl,
		write('of your stump leg you have tripped on'),nl,
		write('a board that'' sticking out.'),nl,
		write('Sound of you falling has alerted Shia'),nl,
		write('There is nowhere to run'),nl,
        die.

kill :-
		i_am_at(small_cottage),
		path(small_cottage, fighting_scene),
        retract(i_am_at(_X)),
        assert(i_am_at(fighting_scene)),
        look, !.

next_episode :-
		i_am_at(fighting_scene),
		write('Safe at last from Shia LaBeouf'),nl,
		likeif,
		write('But you have won; you have beaten'),nl,
		write('Shia LaBeouf'),nl,
		is_it_the_end.


likeif :- 
		i_am_at(fighting_scene),
		leg(cut_off),
		write('You limp into the dark woods'),nl,
		write('blood oozing from your stump leg'),nl.

likeif :- 
		i_am_at(fighting_scene),
		leg(fine),
		retract(shia(alive)),
        assert(shia(dead)),
		write('You walk into the dark woods'),nl,
		write('oddly safe and sound'),nl,
		write('wondering if it''s all you could have experience...'),nl.


is_it_the_end :-
		i_am_at(fighting_scene),
		leg(cut_off),
		shia(alive),
		write('Wait! He isn''t dead (Shia surprise)'),nl,
		write('There''s a gun to your head and death in his eyes'),nl,nl,
		write('Can you do Jis Jitsu:'), nl,
		write('		yes.'), nl,
		write('		no.'), nl.

is_it_the_end :-
		i_am_at(fighting_scene),
		shia(dead),
		nl,nl, 
		write('Congratulations you have beaten the game!'),nl,
		write('There may be another ending!'),nl,
		!, die.


no :-
		i_am_at(fighting_scene),
		leg(cut_off),
		write('Bullet is swift, death is painless'),nl,
		write('Thankfully'),nl,
		!, die.

yes :-
		i_am_at(fighting_scene),
		leg(cut_off),
		retract(shia(alive)),
        assert(shia(dead)),
		write('But you can do Jis Jitsu'),nl,
		write('Body slam superstar Shia LaBeouf'),nl,
		write('Legendary fight with Shia LaBeouf'),nl,
		write('Normal Tuesday night for Shia LaBeouf'),nl,
		write('You try to swing an axe at Shia Labeouf'),nl,
		write('But blood is draining fast from your stump leg'),nl,
		write('He''s dodging every swipe, he parries to the left'),nl,
		write('You counter to the right, you catch him in the neck'),nl,
		write('You''re chopping his head now'),nl,
		write('You have just decapitated Shia Labeouf'),nl,
		write('His head Topples to the floor, expressionless'),nl,
		write('You fall to your knees and catch your breath'),nl,
		write('You''re finally safe from Shia Labeouf'),nl,
		is_it_the_end.


scream_for_help :-
		i_am_at(trap),
		write('You scream tirelessly hoping for someone to help you'), nl,
		write('You seem to forget how you found yourself in this position'), nl,
		write('''Hello there, I''ve been looking all over for you'''), nl,
		write('You hear Shia''s voice from behind'), nl,
		!, die.


/* This rule tells how to die. */

die :-
        !, finish.


/* Under UNIX, the   halt.  command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final  halt.  */

finish :-
        nl,
        write('The game is over. Please enter the   halt.   command.'),
        nl, !.

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        nl,
        write('This whole game is based on fanfiction called'), nl,
        write('Actual cannibal Shia LaBeouf'), nl,
    	nl,
        write('I wholeheartedly recommend watching music version'), nl,
        write('"Shia LaBeouf" Live - Rob Cantor'), nl,
        write('https://www.youtube.com/watch?v=o0u4M6vppCI'), nl,
        write('Great 3 minute music video'), nl, 
        nl,
        write('After playing, because there are spoilers!'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        look.


/* These rules describe the various rooms. */

describe(woods) :-
		write('You''re walking in the woods'), nl,
		write('There''s no one around and your phone is dead'), nl,
		write('Out of the corner of your eye you spot him:'), nl,
		write('Shia LaBeouf.'), nl.

describe(further_down) :-
		write('He''s following you, about 30 feet back'), nl,
		write('He gets down on all fours and breaks into a sprint'), nl,
		write('He''s gaining on you'), nl,
		write('Shia LaBeouf'), nl.

describe(shia_autograph) :-
        write('As you aproach him, you can see Shia LaBeouf''s '), nl,
        write('face is all covered in blood.'), nl,
        write('Before you can react he slashes your throat'), nl,
        write('with a knife. The last thing you see is'), nl,
        write('Legendary Superstar Shia LaBeouf'), nl,
        write('drinking your blood.'), nl,
        die.
describe(far_away) :-
		write('Running for you life (from Shia LaBeouf)'),nl,
		write('He''s brandishing a knife (It''s Shia LaBeouf)'),nl,
		write('Lurking in the shadows'),nl,
		write('Hollywood superstar Shia LaBeouf'),nl,
		write('Living in the woods (Shia LaBeouf)'),nl,
		write('Killing for sport (Shia LaBeouf)'),nl,
		write('Eating all the bodies'),nl,
		write('Actual cannibal Shia LaBeouf'),nl,
		nl,
		write('Now it''s dark and you seem to have lost him'),nl,
		write('but you''re hopelessly lost yourself'),nl.


describe(fighting_scene) :-
		write('You''re sneaking up behind him'),nl,
		write('Strangling superstar Shia LaBeouf'),nl,
		write('Fighting for your life with Shia LaBeouf'),nl,
		write('Wrestling a knife from Shia LaBeouf'),nl,
		write('Stab him in his kidney'),nl,
		next_episode.

describe(trap) :-
		write('Hope! You move stealthily toward it'),nl,
		write('but your leg! Ah! It''s caught in a bear trap!'),nl,
		retract(leg(fine)),
        assert(leg(cut_off)).

describe(small_cottage) :-
		write('Now you''re on the doorstep'),nl,
		write('Sitting inside: Shia LaBeouf'),nl,
		write('Sharpening an axe (Shia LaBeouf)'),nl,
		write('But he doesn''t hear you enter (Shia LaBeouf)'),nl.
