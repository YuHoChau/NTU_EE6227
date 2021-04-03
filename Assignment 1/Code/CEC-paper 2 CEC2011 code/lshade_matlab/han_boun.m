function [x n xmax xmin] = han_boun (x, n, xmax, xmin, I_fno,i)
switch I_fno;
    %%%%%%%%%%%%%%%%% Problem 1 (FM)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 1
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 2 (Lennard-Jones)%%%%%%%%%%%%%%%%%%%%%
    case 2
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 3 (The Bifunctional Catalyst Blend Optimal Control)%%%%%%%%%%%%%%%%%%%%%
    case 3
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        
        %%%%%%%%%%%%%%%%% Problem 3 (Stirred Tank Reactor)%%%%%%%%%%%%%%%%%%%%%
    case 4
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 5 (Si (B))%%%%%%%%%%%%%%%%%%%%%
    case 5
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 6 (Si(C))%%%%%%%%%%%%%%%%%%%%%
    case 6
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        
        %%%%%%%%%%%%%%%%% Problem 7 (Spread Spectrum)%%%%%%%%%%%%%%%%%%%%%
    case 7
        for j=1: n
           if( x(i,j) <xmin (j))
                x(i,j)=   (xmin (j)+ xmax (j))/2;
            else if ( x(i,j)>xmax (j))
                    x(i,j)=  (xmin (j)+ xmax (j))/2;
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 8 (TNEP)%%%%%%%%%%%%%%%%%%%%%
    case 8
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        
        %%%%%%%%%%%%%%%%% Problem 8 (TNEP)%%%%%%%%%%%%%%%%%%%%%
    case 9
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 10%%%%%%%%%%%%%%%%%%%%%
    case 10
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 10_1 %%%%%%%%%%%%%%%%%%%%%
    case 11
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   2* xmin (j) - x(i,j) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   2* xmax (j) - x(i,j) ;
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 10_2 %%%%%%%%%%%%%%%%%%%%%
    case 12
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   2* xmin (j) - x(i,j) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   2* xmax (j) - x(i,j) ;
                end
            end
        end
        %%%%%%%%%%%%%%%%% Problem 11_1 %%%%%%%%%%%%%%%%%%%%%
    case 13
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        %%%%%%%%%%%%%%%%% Problem 11_2 %%%%%%%%%%%%%%%%%%%%%
    case 14
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   2* xmin (j) - x(i,j) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   2* xmax (j) - x(i,j) ;
                end
            end
        end
        %%%%%%%%%%%%%%%%% Problem 11_3 %%%%%%%%%%%%%%%%%%%%%
    case 15
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   2* xmin (j) - x(i,j) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   2* xmax (j) - x(i,j) ;
                end
            end
        end
        %%%%%%%%%%%%%%%%% Problem 11_4 %%%%%%%%%%%%%%%%%%%%%
    case 16
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   2* xmin (j) - x(i,j) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   2* xmax (j) - x(i,j) ;
                end
            end
        end
        %%%%%%%%%%%%%%%%% Problem 11_5 %%%%%%%%%%%%%%%%%%%%%
    case 17
         for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 12_1 %%%%%%%%%%%%%%%%%%%%%
    case 18
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 12_2 %%%%%%%%%%%%%%%%%%%%%
    case 19
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
            else if ( x(i,j)>xmax (j))
                    x(i,j)=   xmin (j) +rand*(xmax(j)-xmin(j));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem 12_3 %%%%%%%%%%%%%%%%%%%%%
    case 20
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=  min(xmax(j), max(xmin(j),2* xmin (j) - x(i,j))) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)=  min(xmax(j), max(xmin(j), 2* xmax (j) - x(i,j) ));
                end
            end
        end
        
        %%%%%%%%%%%%%%%%% Problem  (Messenger Full) %%%%%%%%%%%%%%%%%%%%%
    case 21
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)=    xmin (j) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)= xmin (j)  ;
                end
            end
        end
        
        
        
        %%%%%%%%%%%%%%%%% Problem Cassini2 %%%%%%%%%%%%%%%%%%%%%
    case 22
        for j=1: n
            if( x(i,j) <xmin (j))
                x(i,j)= xmin (j) ;
            else if ( x(i,j)>xmax (j))
                    x(i,j)= xmin (j);
                end
            end
        end
        
end
end