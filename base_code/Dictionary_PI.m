function[D]=Dictionary_PI(Y,W)
%Funcion para encontrar un diccinario usado
%las observaciones Y y los coeficientes W
% Retorna:
%	D : Diccionario estimado mediante pseudoinversa
%
% Recibe:
%	Y : Matriz de observaciones
%	W : Matriz de coeficientes


[Ry,Cy]=size(Y);
[Rw,Cw]=size(W);

if Cy~=Cw
    fprintf('no se pudo');
    D=[];
	return
end

%calculando pseudoinversa derecha
A=W*W';
A=inv(A);
A=W'*A;
%A=pinv(W);

%calculando pseudoinversa izquierda
B=W'*W;
B=inv(B);
B=B*W';

Dr=Y*A;
Dl=Y*B;

D=Dl;
end
