

% Devendra Pratap Yadav
% Edge Detection using Fuzzy Logic
 
format long ;  
a = imread('image.jpg') ; 
ss = size(a) ; 
 
type = size(ss) ;
type = type(1,2) ;
 
var = 5; 
fvar = 10 ; 
 
if(type == 3) 
 
    r = ss(1,1) ;
    c = ss(1,2) ;
    z = ss(1,3) ;
 
    a(:,:,1) = medfilt2(edged(a(:,:,1), var, fvar)) ;
    a(:,:,2) = medfilt2(edged(a(:,:,2), var, fvar)) ;
    a(:,:,3) = medfilt2(edged(a(:,:,3), var, fvar)) ;
    
    imshow(a) ;
 
end
 
if(type == 2)
 
    r = ss(1,1) ;
    c = ss(1,2) ;
 
  
	b = medfilt2(a);
	ss = size(b) ; 
	r = ss(1,1) ; c = ss(1,2) ;
	 
	m = zeros(r,c) ; 
	 
	for i=2:1:r-1
		
		for j=2:1:c-1
			
			if(abs(b(i,j)-b(i,j-1)) > var)
				m(i,j)= b(i,j-1);
			end
			
			if(abs(b(i,j)-b(i-1,j)) > var)
				m(i,j)=b(i-1,j) ;
			end
			
			if(abs(b(i,j)-b(i-1,j-1)) > var)
				m(i,j)=b(i-1,j-1) ;
			end
			
			if(abs(b(i,j)-b(i,j+1)) > var)
				m(i,j)=b(i,j+1) ;
			end
			
			if(abs(b(i,j)-b(i+1,j)) > var)
				m(i,j)=b(i+1,j) ;
			end
			
			if(abs(b(i,j)-b(i+1,j+1)) > var)
				m(i,j)=b(i+1,j+1) ;
			end
		   
		end
		
	end
	n = zeros(r,c) ; 
	 
	for i=2:1:r-1
		
		for j=2:1:c-1
		   
			mem = 0 ;
			
			mem = mem + abs(b(i,j)-b(i,j-1)) ;
			mem = mem + abs(b(i,j)-b(i-1,j-1)) ;
			mem = mem + abs(b(i,j)-b(i-1,j)) ;
			mem = mem + abs(b(i,j)-b(i,j+1)) ;
			mem = mem + abs(b(i,j)-b(i+1,j+1)) ;
			mem = mem + abs(b(i,j)-b(i+1,j)) ;
			
			if(mem > fvar)
				n(i,j) = b(i,j)  ;
			end
			
		end
		
	end 
	mat = [m;n] ; 


    p = [a;mat] ;
 
    imshow(p) ;
    
end
