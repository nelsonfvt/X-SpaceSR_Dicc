function [W,DD1,K]=CreaDiccionariokmeans(Nparches,Nvoxls,Dicc,Obsr,cantgrad,bob)
%% DICCIONARIO SPLINE
    L =Nparches;% 1260;%L numero de parches b0
    N = Nvoxls;%216; %M voxeles /parche
    K = cantgrad;%L*cantgrad; %K # gradientes que se van a utilizar * L
    DD = double(Dicc(1:N,1:K)); 
    XX = Obsr(1:N,1:L); 
  % or
  % Wi = zeros(K,L); for i=1:L; Wi(:,i) = randperm(K); end;
  % Wt = zeros(K,L); Wt(Wi <= 5) = randn(5*L,1); X = D*Wt + 0.01*randn(N,L);
  %op = struct('targetNonZeros',5, 'verbose', 2);
  
  
  %W(K,L)=0;
 
for it = 1:30%noIt
%     for con=1:length(XX(1,:))
%         clear vars coeff1 iopt1
%     [yfit1,r1,coeff1,iopt1,qual1] = wmpalg('OMP',XX(:,con),DD,'itermax',bob);
%         for N=1:bob
%     W(iopt1(N),con)=coeff1(N); 
%         end
%     end
   
   
    W = sparseapprox(XX, DD, 'mexOMP','tnz',bob);%%sparseapprox(XX, DD, 'mexOMP', 'tnz',bob);
    R = XX - DD*W;
    for k=1:K
       I = find(W(k,:));
        if(isempty(I)==0)
            Ri = R(:,I) + DD(:,k)*W(k,I);
            [U,S,V] = svds(Ri,1,'L');
            % U is normalized
            DD(:,k) = U;
            W(k,I) = S*V';
            R(:,I) = Ri - DD(:,k)*W(k,I);
        end
    end    
end 


cont=1;
for k=1:K
     I = find(W(k,:));
        if(isempty(I)==0)
   % if (norm(DD(:,k))==1)
        DD1(:,cont)=DD(:,k);
        W1(cont,:)=W(k,:);
        K(cont)=k;
        cont=cont+1;
    end
end

%cont=1;


end
