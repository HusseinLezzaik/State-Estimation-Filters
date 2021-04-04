function pred_state = modele_evolution( prev_state, input, Te)

% Parametre du modele
L = 2;

% Modele discret                         %
% A modifier                               %
dx = [  0 ;
        0 ;
        0 ] ;

pred_state = prev_state + dx ;
