function  out = displaystate( varargin )

persistent fig hs hb hp max_part ;

if nargin == 3
    ref_traj = varargin{1} ;
    Xbal = varargin{2} ;
    Npart = varargin{3} ;
    
    max_part =Npart  ;
    
    % Create figure
    if isempty( fig )
        fig = figure( 'Name' , 'State' );
        plot( ref_traj(1,:) , ref_traj(2,:) , 'r' , 'linewidth' , 2 );
        hold on;
        hs = plot( ref_traj(1,:) , ref_traj(2,:) , 'ro' , 'linewidth' , 2 );
        grid on;
        axis equal;
        hb = plot( Xbal(1,:) , Xbal(2,:) , 'bo' , 'linewidth' , 2 );
        if Npart <= max_part
            for k = 1 : Npart
                hp(k) = plot( 0 , 0 , 'k.' , 'linewidth' , 2 );
                set( hp(k) , 'EraseMode' , 'xor' );
            end
        else
            for k = 1 : max_part
                hp(k) = plot( 0 , 0 , 'k.' , 'linewidth' , 2 );
                set( hp(k) , 'EraseMode' , 'xor' );
            end
        end
            
    end
    
elseif nargin == 2
    Xref = varargin{1};
    part = varargin{2}; 
    map = colormap ;
    T = linspace( min([part.w]) , max([part.w]) , length(map) );
    set( hs , 'XData' , Xref(1) , 'YData' , Xref(2) )
    set( gca , 'Xlim' , Xref(1) + 50 * [-1,1] , 'Ylim' , Xref(2) + 50*3/4 * [-1,1] );
%     [w,idx] = sort([part.w],'ascend');
%     part = part(idx);
    if length( part ) <= max_part
        for i = 1 : length( part )
            idx_scale = indice( part(i).w , T );
            set( hp(i) , 'XData' , part(i).x(1) , 'YData' , part(i).x(2) , 'color' , map(idx_scale,:) ) ;
        end
    else
        for i = 1 : max_part
            idx_scale = indice( part(i).w , T );
            set( hp(i) , 'XData' , part(i).x(1) , 'YData' , part(i).x(2) , 'color' , map(idx_scale,:) ) ;
        end
    end


end

out = fig ;
