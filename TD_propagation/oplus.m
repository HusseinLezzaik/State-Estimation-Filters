function [pos_res, cov_res] = oplus(pos_a, pos_b, cov_a, cov_b, cov_a_b, cov_b_a)
    % if pos_b is a position
    if(size(pos_b, 1) == 2)
        % pos_res = ...
        
        % if cov_a and cov_b are specified
        if(nargin >= 4)
            % if cov_a_b and and cov_b_a are not specified
            if(nargin == 4)
                % cov_a_b = ...
                % cov_b_a = ...
            end
             % cov_res = ...
        else
            cov_res = nan;
        end
    % if pos_b is a pose
    elseif(size(pos_b, 1) == 3)
        % pos_res = ...
        
        % if cov_a and cov_b are specified
        if(nargin >= 4)
            % if cov_a_b and and cov_b_a are not specified
            if(nargin == 4)
                % cov_a_b = ...
                % cov_b_a = ...
            end
             % cov_res = ...
        else
            cov_res = nan;
        end
    else
        disp('error unvalide size(pos_b, 1)');
    end
end