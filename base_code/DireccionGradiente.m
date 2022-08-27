function [I]=DireccionGradiente(vec,val,Data,dirGradiente)
[Xs,Ys,Ts,Gs]=size(Data);
new_dir=vec(:,dirGradiente);
grads = 0;
b0s = 0;
Ngrads = 0;
Nb0 = 0;

n=1;
k=1;

%extraer b0s
for i=1:Gs
        if val(i)>0
                Ngrads = Ngrads+1;
                grads(n)= i;
                n = n+1;
        else
                Nb0 = Nb0+1;
                b0s(k) = i;
                k = k+1;
        end
end

%	N=6; %numero de volumenes a combinar
        Ds = zeros(Ngrads,1);
        sol = single(zeros(Xs,Ys,Ts));

	% calculando productos punto de direcciones de gradiente
        for l=1:Gs%Ngrads        
        	%Ds(l)=abs(new_dir*vec(:,grads(l))');
            if l==b0s(1) || l==b0s(2) || l==b0s(3) 
                Ds(l)=NaN;
            else
            Ds(l)=dot(new_dir/norm(new_dir),vec(:,l))/norm(vec(:,l));
            end
            
        end
        
	
%     
%     %los mas alejados
%             [Dss,I] = sort(abs(Ds));
%        % Tot = sum(Dss(1:N));
%         Tot=(I(1:29));
%         I= fliplr(Tot);
        
      %los mas cercanos
        [Dss,I] = sort(abs(Ds),'descend');
%         Tot = sum(Dss(1:N));
        Tot=(I(5:33));%% de 4:33 es del mas cercano al mas lejano
        I= fliplr(Tot);% TOMO TODOS LOS MAS CERCANOS
end
