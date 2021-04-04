%  TD filtrage particulaire.
clear all; close all; clc;

load('data');% Lecture des donnees
k_max = length(t); %nb echantillons

% Configuration du filtre
N = 5 ; %Nb particules (à changer)
x0 = [0;0;0]; % état initial

%%  Filtre  %%
wb = waitbar(0);%indicateur de progression du traitement

%on cree des matrices pour sauvegarder les vecteurs
X_MMSE = zeros(3,k_max); %Minimum Mean Square Error
X_MAP = zeros(3,k_max);   %Maximum A Posteriori
e_MMSE = zeros(1,k_max) ;%erreur d'estimation MMSE
e_MAP = zeros(1,k_max);   %erreur d'estimation MAP

displaystate( ref_traj , P_balises , N );%fonction d'affichage

% Initialisation des particules 
% A modifier !
for i = 1 : N
    particle(i).x = x0  ;
    particle(i).w = 1/N ;
end

for k = 1 : k_max;
    %---------------------------------------------------------------------
    %  Evolution de chaque particule                          
    %  Completer la fonction modele_evolution 
    %  Faire le tirage aléatoire de façon à bruiter l'entrée u
    for i = 1 : N
        particle(i).x = modele_evolution(particle(i).x,u(:,k),Te) ;
    end
    %---------------------------------------------------------------------
    % Mise a jour des poids       
    for i = 1 : N
        particle(i).w = particle(i).w ; % A changer 
    end
    %---------------------------------------------------------------------
    % Normalisation des poids
    for i = 1 : N
        particle(i).w = particle(i).w ; % A changer
    end
    %---------------------------------------------------------------------
    % Estimateurs
    for i = 1:N
        % on calcule la moyenne de façon incrémentale
        X_MMSE(:,k) = X_MMSE(:,k) + particle(i).w * particle(i).x ;
    end
    e_MMSE(k)  = norm( X_MMSE(:,k) - ref_traj(:,k) ) ;
     
    [m,idx] = max( [particle.w] );
    X_MAP(:,k) = particle(idx).x ;
    e_MAP(k)   = norm( X_MAP(:,k) - ref_traj(:,k) ) ;
    
    %---------------------------------------------------------------------
    % Reechantillonnage
    Neff = 1 ; % A changer
    Nth = 0 ;  % A changer
    if( Neff < Nth )
         particle = kitagawa_resample( particle );
    end
    
    % Affichage
    displaystate( ref_traj(:,k) , particle );
    waitbar(k/k_max,wb);
end
close(wb);

%% Affichage des résultats
figure;
plot( ref_traj(1,:) , ref_traj(2,:) , 'ro--' , X_MAP(1,:) , X_MAP(2,:) , 'g*--' , X_MMSE(1,:) , X_MMSE(2,:) , 'b.--' , P_balises(1,:) , P_balises(2,:) , 'bo' ) ;
grid on;
axis equal;
legend('Position vraie' , 'MAP' , 'MMSE' , 'Balises' ,'Location','NorthWest');
xlabel( 'x (m)' );ylabel( 'y (m)' );
title('Evolution dans le plan');

figure;
plot( t, e_MAP , 'g*--' , t, e_MMSE , 'b.--' ) ;
legend('MAP' , 'MMSE' ,'Location','NorthWest');
grid on;
ylabel('(m)'); xlabel( 't (s)' );
title('Erreurs')

