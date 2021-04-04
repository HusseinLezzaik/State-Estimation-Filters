% close all;
clear all;
clc;


load('dataset_propagation.mat');

sleeping_time = 0.001;
zoom = 10;
flag_display = true;

flag_part1 = false;
flag_part2 = false;
flag_part3 = false;
flag_part4 = false;

res_pos_f_in_ref = [];
res_pos_l_in_ref = [];

pos_odom = data(1).pos_ref_f;
cov_odom = data(1).cov_ref_f;

nb_particles = 1000;
pos_odom_particles = [pos_odom(1)*ones(1, nb_particles);
                      pos_odom(2)*ones(1, nb_particles);
                      pos_odom(3)*ones(1, nb_particles)];

for(i = 2:1901)
    
    % part 1
    if(flag_part1)
        % data(i).pos_ref_f : reference pose of the follower
        % data(i).cov_ref_f : reference covariance matrix of the follower
        % data(i).pos_ref_l : reference pose of the leader
        % data(i).cov_ref_l : reference covariance matrix of the leader
        % data(i).pos_l_in_f : pose of the leader in the follower frame
        % data(i).cov_l_in_f : covariance matrix of the leader in the follower frame
        
        % [pos_f, cov_f] = ...
        % [pos_l, cov_l] = ...
    end
    
    % part 2
    if(flag_part3)
        % pos_f_in_ref = ...
        % pos_l_in_ref = ...

%         res_pos_f_in_ref = [res_pos_f_in_ref pos_f_in_ref];
%         res_pos_l_in_ref = [res_pos_l_in_ref pos_l_in_ref];
    end
    
    % part 3
    if(flag_part3)
        particles_ref_f = mvnrnd(data(i).pos_ref_f, round(data(i).cov_ref_f, 8), nb_particles)';
        particles_ref_l = mvnrnd(data(i).pos_ref_l, round(data(i).cov_ref_l, 8), nb_particles)';
        particles_l_in_f = mvnrnd(data(i).pos_l_in_f, round(data(i).cov_l_in_f, 8), nb_particles)';
        
        % particles_f = ...
        % particles_l = ...
    end
    
    % part 4
    if(flag_part4)
        % data(i).vel_f(1) : longitudinal speed
        % data(i).vel_f(2) : rotation speed
        % data(i).time : time at iteration i
        
        cov_vel = [0.3 0.0; 0.0 0.001];
        
        % [pos_odom, cov_odom] = ...
    end
        
    if(flag_display)
        figure(1);
        clf;
        hold on;
        %Map display
        plot(map(:,1),map(:,2), '-k');
        
        % Display of the follower
        displayPos(data(i).pos_ref_f, 1, 'b');
        displayCov(data(i).pos_ref_f, data(i).cov_ref_f, 0.95, 'b');
        % Display of the leader
        displayPos(data(i).pos_ref_l, 1, 'b');
        displayCov(data(i).pos_ref_l, data(i).cov_ref_l, 0.95, 'b');
        
        if(flag_part1)
            % Display of the follower
            displayPos(pos_f, 1, 'r');
            displayCov(pos_f, cov_f, 0.95, 'r');
            
            % Display of the leader
            displayPos(pos_l, 1, 'r');
            displayCov(pos_l, cov_l, 0.95, 'r');
        end
        if(flag_part3)
            % Display of the follower particles
            sct = scatter(particles_f(1,:), particles_f(2,:), 5, 'r', 'filled');
            sct.MarkerFaceAlpha = 0.1;
            % Display of the leader particles
            sct = scatter(particles_l(1,:), particles_l(2,:), 5, 'r', 'filled');
            sct.MarkerFaceAlpha = 0.1;
        end
        if(flag_part4)
            % Display of the odometry            
            displayPos(pos_l, 1, 'r');
            displayCov(pos_odom, cov_odom, 0.95, 'm');
        end

        hold off;
        
        axis equal;

        xlabel('m');ylabel('m');title('The two cars on SEVILLE (ENU coordinates)');
        
        if zoom == 0 %no zoom; full display of the map
            xlim([-320 -200]);
            ylim([290 390]);
        else %zoom in view
            xlim([(data(i).pos_ref_f(1)+data(i).pos_ref_l(1))/2-zoom...
                  (data(i).pos_ref_f(1)+data(i).pos_ref_l(1))/2+zoom]);
            ylim([(data(i).pos_ref_f(2)+data(i).pos_ref_l(2))/2-zoom...
                  (data(i).pos_ref_f(2)+data(i).pos_ref_l(2))/2+zoom]);
        end
        
        pause(sleeping_time);
    end 
    
end

if(flag_part2)
    figure(2);
    clf
    hold on;
    sct = scatter(res_pos_f_in_ref(1,:), res_pos_f_in_ref(2,:), 15, 'r', 'filled');
    sct.MarkerFaceAlpha = 0.1;
    sct = scatter(res_pos_l_in_ref(1,:), res_pos_l_in_ref(2,:), 15, 'g', 'filled');
    sct.MarkerFaceAlpha = 0.1;
    hold off
    axis equal;
end