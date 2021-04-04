function resampled_part = kitagawa_resample( part )
    %Rééchantillonnage d'un jeu de particules selon la méthode de Kitagawa
    N = length(part);
    q = cumsum( [part.w] );
    aux=rand(1);
    u=[aux:1:(N-1+aux)]/N;
    j=1;
    N_babies = zeros(1,N);
    for i=1:N
        while (u(i)>q(j))
            j=j+1;
        end
    N_babies(1,j)=N_babies(1,j) + 1;
    end
    
    index=1;
    inIndex = [1:N] ;
    for i=1:N
      if (N_babies(1,i)>0)
        for j=index:index+N_babies(1,i)-1
          outIndex(j) = inIndex(i);
        end;
      end;   
      index= index+N_babies(1,i);   
    end
    resampled_part = part(outIndex) ;

    sw = sum( [resampled_part.w] );
    for k = 1 : N
        resampled_part(k).w = resampled_part(k).w / sw ;
    end
    
end