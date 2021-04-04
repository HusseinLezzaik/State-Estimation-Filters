%Cooperative state estimation based on Covariance Intersection
%template file to be completed
clear
clc
close all
load dataset_CIF.mat;

%Uncomment the two following lines for an accurate leader position
%To be used for question 5
%data.x_l = data.x_l_ref + randn(110,1)*0.1;
%data.x_l_std = 0.1;

nepoch=length(data.t);

results = struct();
results.X_l = zeros(nepoch,1);
results.X_f = zeros(nepoch,1);
results.P_l = ones(nepoch,1)*100;
results.P_f = ones(nepoch,1)*100;

X_l = data.x_l_ref(1);
X_f = data.x_f_ref(1);
P_l = 100;
P_f = 100;

%The two filters are implemented in the same loop
%So, every step has to be duplicated for every vehicle
for i=1:nepoch
    % measurement updates 
    %...
    
    % Storage (corresponds to the output of the filter)
    results.X_l(i) = X_l;
    results.X_f(i) = X_f;
    results.P_l(i) = P_l;
    results.P_f(i) = P_f;
    
    % time updates (prediction)
    %...
    
end

% Errors display with +/- 2 sigma bounds
figure;
plot(data.t, results.X_l-data.x_l_ref);zoom on;hold on;
plot(data.t, 2*sqrt( results.P_l),'r'); plot(data.t,-2*sqrt( results.P_l),'r'); ylabel('x');
xlabel('t (s)');
title('Leader estimation error with +/- 2 sigma bounds');

figure;
plot(data.t, results.X_f-data.x_f_ref);zoom on;hold on;
plot(data.t,2*sqrt( results.P_f),'r');plot(data.t,-2*sqrt( results.P_f),'r');ylabel('x');
xlabel('t (s)');
title('Follower estimation error with +/- 2 sigma bounds');
  
disp(['Leader mean square error: ', num2str(sqrt(mean( (results.X_l-data.x_l_ref).^2 )))]);
disp(['Follower mean square error: ', num2str(sqrt(mean( (results.X_f-data.x_f_ref).^2 )))]);

disp(['Leader consistency: ', num2str(mean( (results.X_l-data.x_l_ref)./results.P_l.*(results.X_l-data.x_l_ref) < 3.841 ))]);
disp(['Follower consistency: ', num2str(mean( (results.X_f-data.x_f_ref)./results.P_f.*(results.X_f-data.x_f_ref) < 3.841 ))]);
