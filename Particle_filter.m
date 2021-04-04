%  TD particle filtering

clear;
close all;
clc;

load('data');
k_max = length(t); 

% Filter configuration

x0_bounds=[-620; -550];
y0_bounds=[-200; -50];
th_bounds=[0; 30];

x0_samples=5;
y0_samples=8;
th_samples=6;

effective_percentage=.2;

x0 = []; 
for i1=1:x0_samples
    for i2=1:y0_samples
        for i3=1:th_samples
            x0=[x0 [(x0_bounds(2)-x0_bounds(1))/x0_samples*(i1-1)+x0_bounds(1);
                (y0_bounds(2)-y0_bounds(1))/y0_samples*(i2-1)+y0_bounds(1);
                (th_bounds(2)-th_bounds(1))/th_samples*(i3-1)+th_bounds(1);]];
        end
    end
end

N = size(x0,2) ; 

wb = waitbar(0); %indicator of processing progress
%matrices to save the vectors
X_MMSE = zeros(3,k_max);  %Minimum Mean Square Error
X_MAP = zeros(3,k_max);   %Maximum A Posteriori
e_MMSE = zeros(1,k_max) ; %Estimation error MMSE
e_MAP = zeros(1,k_max);   %Estimation error MAP
displaystate( ref_traj , P_balises , N );%display function
pause(1)

for i = 1 : N
    particle(i).x = x0(:,i); 
    particle(i).w = 1/N ; 
end

s = 20; % for uniform distribution
for k = 1 : k_max
    %---------------------------------------------------------------------
    %  Evolution of each particle                          
    %  Fill in the evolution function 
    %  Make a random draw in order to noise the input u
    %  This is more efficient than adding a noise on the state.                         
    for i = 1 : N
        particle(i).x = evolution_model(particle(i).x, ...
                            u(:,k)+[randn(); randn()], Te) ;
    end
    
    % Weight update    
    for i = 1 : N
        xi = particle(i).x(1);
        yi = particle(i).x(2);
        
        weight_update = 0;        
        for j=1:size(P_balises,2)
            prediction = sqrt((P_balises(1,j)-xi)^2+(P_balises(2,j)-yi)^2);
            %%%%%%%%%%%%%% change %%%%%%%%%%%%%%%
            weight_update = weight_update + ((y(j,k)-prediction)/s)^2  ;            
        end       
        particle(i).w = particle(i).w * exp(-1/2 * weight_update) ;        
    end
    
    % Weight normalization
    totalWeigth = 0;
    for i = 1 : N        
        totalWeigth = totalWeigth +particle(i).w;
    end
    
    for i = 1 : N     
        particle(i).w = particle(i).w / totalWeigth ;
    end
    
    % Estimators
    for i = 1:N
        X_MMSE(:,k) = X_MMSE(:,k) + particle(i).w * particle(i).x ;
    end  
    e_MMSE(k)  = norm( X_MMSE(:,k) - ref_traj(:,k) ) ;
     
    [m,idx] = max( [particle.w] );
    X_MAP(:,k) = particle(idx).x ;
    e_MAP(k)   = norm( X_MAP(:,k) - ref_traj(:,k) ) ;
    
    % Resampling
    weights_sum = 0;
    for i = 1:N
        weights_sum = weights_sum + particle(i).w^2;
    end
    Neff = 1/weights_sum  ; 
    Nth = N*effective_percentage;
    if( Neff < Nth )
         particle = kitagawa_resample( particle );
    end
    
    % Display
    displaystate_( ref_traj(:,k) , particle );
    waitbar(k/k_max,wb);
end
close(wb);

% Display of the results
figure;
plot( ref_traj(1,:) , ref_traj(2,:) , 'ro--' , X_MAP(1,:) , X_MAP(2,:) , 'g*--' , X_MMSE(1,:) , X_MMSE(2,:) , 'b.--' , P_balises(1,:) , P_balises(2,:) , 'bo' ) ;
grid on;
axis equal;
legend('True position' , 'MAP' , 'MMSE' , 'Beacons' ,'Location','NorthWest');
xlabel( 'x (m)' );ylabel( 'y (m)' );
title('Evolution in the plan');

figure;
plot( t, e_MAP , 'g*--' , t, e_MMSE , 'b.--' ) ;
legend('MAP' , 'MMSE' ,'Location','NorthWest');
grid on;
ylabel('(m)'); xlabel( 't (s)' );
title('Errors')

function prediction = observation_model(state, beacon)
    prediction = sqrt((beacon(1)-state(1))^2+(beacon(2)-state(2))^2);
end
