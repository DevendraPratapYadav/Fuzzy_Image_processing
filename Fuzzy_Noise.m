
% Devendra Pratap Yadav
% Noise Reduction using Fuzzy Filtering

A= imread('image.jpg');
imshow(A);
figure
A=double(A);
A=rgb2hsv(A);

H=A(:,:,1);
S=A(:,:,2);
V=A(:,:,3); 

% we operate on V

row=size(V,1);
col=size(V,2);

Vn=V;
Vm=medfilt2(V,[6 6]);

sdmin=1000;
for i=[1:8:row-8]
    for j=[1:8:col-8]

        ST=std2(V(i:i+8,j:j+8));
        sdmin=min([ST,sdmin]);
        
        
    end


end


ST=V(100:110,50:60);

p=sdmin*6;


for i=3:row-3
    for j=4:col-3
        
        B=V(i-1:i+1,j-1:j+1);
        uu=V(i-2,j); dd=V(i+2,j); ll=V(i,j-2); rr=V(i,j+2);
        corr=0;
        
        BB=B;
         BB(2,2)=BB(1,1);
        sdd=std2(BB);
        
       
        mm=B(1,1)+B(1,2)+B(1,3)+B(2,1);
        mm=mm/4;
        
        
        if(sdd<p/4)
            if (abs(mm-Vn(i,j))>p/4)
                Vn(i,j)=Vm(i,j);%mean(mean(BB));
                continue
            end
        end
        
        
        
        % |
        % |->
        % |
        a=B(1,2); b=B(2,2); c=B(3,2);
        da=B(1,2)-B(1,3);db=B(2,2)-B(2,3); dc=B(3,2)-B(3,3);
        
        %d=(abs(da)+abs(db)+abs(dc))/3;
         d=min( [ abs(da);abs(db);abs(dc) ] );
        d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(2,3)-B(2,2);
        
        corr=corr+d*diff;
        
        %   |
        % <-|
        %   |
        a=B(1,2); b=B(2,2); c=B(3,2);
        da=a-B(1,1);db=b-B(2,1); dc=c-B(3,1);
        
        %d=(abs(da)+abs(db)+abs(dc))/3;
        d=min( [ abs(da);abs(db);abs(dc) ] );
        
        d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(2,1)-B(2,2);
        
        corr=corr+d*diff;
        
        
        
        %   ||
        % _ _ _
        %   
        a=B(2,1); b=B(2,2); c=B(2,3);
        da=a-B(1,1);db=b-B(1,2); dc=c-B(1,3);
        
        %d=(abs(da)+abs(db)+abs(dc))/3;
        
        d=min( [ abs(da);abs(db);abs(dc) ] );
        d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(1,2)-B(2,2);
        
        corr=corr+d*diff;
        
        
        
        
        % _ _ _
        %   ||
        a=B(2,1); b=B(2,2); c=B(2,3);
        da=a-B(3,1);db=b-B(3,2); dc=c-B(3,3);
        
       % d=(abs(da)+abs(db)+abs(dc))/3;
       d=min( [ abs(da);abs(db);abs(dc) ] ); 
       
       d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(3,2)-B(2,2);
        
        corr=corr+d*diff;
        
        
        
         % \ 
        % <-\
        %    \
        a=B(1,1); b=B(2,2); c=B(3,3);
        da=a-ll;db=b-B(3,1); dc=c-dd;
        
        %d=(abs(da)+abs(db)+abs(dc))/3;
        d=min( [ abs(da);abs(db);abs(dc) ] );
        
        d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(3,1)-B(2,2);
        
        corr=corr+d*diff;
        
        
        
        % \ 
        %   \->
        %    \
        a=B(1,1); b=B(2,2); c=B(3,3);
        da=a-uu;db=b-B(1,3); dc=c-rr;
        
        %d=(abs(da)+abs(db)+abs(dc))/3;
        d=min( [ abs(da);abs(db);abs(dc) ] );
        
        d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(1,3)-B(2,2);
        
        corr=corr+d*diff;
        
        
        %     /
        % <-/ 
        % /  
        a=B(1,3); b=B(2,2); c=B(3,1);
        da=a-uu;db=b-B(1,1); dc=c-ll;
        
       % d=(abs(da)+abs(db)+abs(dc))/3;
       d=min( [ abs(da);abs(db);abs(dc) ] );
       
       d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(1,1)-B(2,2);
        
        corr=corr+d*diff;
        
        
        %     /
        %   / ->
        % /  
        a=B(1,3); b=B(2,2); c=B(3,1);
        da=a-rr;db=b-B(3,3); dc=c-dd;
        
        %d=(abs(da)+abs(db)+abs(dc))/3;
        d=min( [ abs(da);abs(db);abs(dc) ] );
        d=d/p;
        
        if (d>1)
            d=1;
        end
        
        d=1-d;
        diff=B(3,3)-B(2,2);
        
        corr=corr+d*diff;
        
        
        Vn(i,j)=Vn(i,j)+corr/8;
        
        %Vm(i,j)=mean(mean(B));
        
    end
end



V=Vn;
% standard dev  =>  val = std2(I);

fimg=cat(3,H,S,V);
fimg=hsv2rgb(fimg);

fimg=uint8(fimg);
imshow(fimg);
imwrite(fimg,'m.jpeg');
figure

fimg=cat(3,H,S,Vm);
fimg=hsv2rgb(fimg);

fimg=uint8(fimg);
imshow(fimg);




