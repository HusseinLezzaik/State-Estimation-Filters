%function [z]=indice(t_ref,t,option_recherche)
%tref est un instant et t un vecteur d'instants croissants
%routine pour rechercher l'indice dans t, du temps le plus proche de tref
%option_recherche est la variante voulue par l'utilisateur de la fonction :
%si option_recherche=0, on cherche le plus proche
%si option_recherche=1 on cherche le premier superieur si on ne depasse pas la taille de t 
%sinon et par defaut on prend le dernier inferieur a t_ref

% aout 03 amadou 
% version 2 jui 05 sans boucle ni recherche dicotomique
% révision phb du 7/7/05
%revision amadou 11/7/05 indice rendu compatible avec les anciens programmes comme find_index

function [z]=indice(t_ref,t,option_recherche)
if nargin==2, option_recherche =-1; end;
n=length(t);

if (option_recherche==0)
    auxi=abs(t -t_ref);
    z=find(auxi == min(auxi));
    
elseif (option_recherche==1)
    if(t_ref<=t(n))
        z=min(find(t>=t_ref));
    else
        z=n;
    end
    
else
    if(t_ref>=t(1))
        z=max(find(t<=t_ref));
    else
        z=1;
    end
    
end

