% Model for a fast implementation of Kalman filter
% Ph. Bonnifait
clear
clc
load simulated_data.mat; %load variables in the workspace

nepoch=length(t);

%size of the state
n=4; %for instance X=(x,y,vx,vy) - to be changed

% Variables used to store the results
Xs=zeros(n,nepoch); 
%If we want to store some terms of the covariance matrix, wr allocate
%before some memory
Px1=zeros(1,nepoch); %variance
Px1x2=zeros(1,nepoch); %covariance

% Initial state of the filter (to be changed)
X=zeros(n,1);
P=100*eye(n,n);

for i=1:nepoch
    % measurement update (estimation)
    %...
    
    % Storage (corresponds to the output of the filter)
    Xs(:,i)=X;
    Px1(i)=P(1,1);
    Px1x2(i)=P(1,2);
    %...
    
    % time update (prediction)
    %...
end

% Estimate + reference display
figure
plot(t,strada.x,t,Xs(1,:)','r');
ylabel('m');
xlabel('t (s)');
title('Estimate and ground truth');
legend('Ground truth','Estimate');

% Errors display with +/- 3 sigma bounds
figure;
plot(t,Xs(1,:)'-strada.x);zoom on;hold on;
plot(t,3*sqrt(Px1),'r');plot(t,-3*sqrt(Px1),'r');ylabel('x');
xlabel('t (s)');
title('Estimation error with +/- 3 sigma bounds');

disp(['Error mean in x= ', num2str(mean(Xs(1,:)'-strada.x)),...
      '. Error max in x= ', num2str(max(abs(Xs(1,:)'-strada.x)))]);
