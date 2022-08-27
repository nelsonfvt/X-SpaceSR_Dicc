function [VolumenBaja]=BajaResolucionMj(volumenHR,Ts,Ys,Xs)

for z=1:Ts/2%1:30
for y=1:Ys/2%1:64
for x=1:Xs/2%1:64
	volumenLR(x,y,z)=volumenHR(2*x,2*y,2*z);
	volumenLR(x,y,z)=volumenLR(x,y,z)+volumenHR(2*x-1,2*y-1,2*z);
	volumenLR(x,y,z)=volumenLR(x,y,z)+volumenHR(2*x-1,2*y,2*z);
	volumenLR(x,y,z)=volumenLR(x,y,z)+volumenHR(2*x,2*y-1,2*z);
	volumenLR(x,y,z)=volumenLR(x,y,z)+volumenHR(2*x,2*y,2*z-1);
	volumenLR(x,y,z)=volumenLR(x,y,z)+volumenHR(2*x-1,2*y-1,2*z-1);
	volumenLR(x,y,z)=volumenLR(x,y,z)+volumenHR(2*x-1,2*y,2*z-1);
	volumenLR(x,y,z)=volumenLR(x,y,z)+volumenHR(2*x,2*y-1,2*z-1);
	volumenLR(x,y,z)=volumenLR(x,y,z)/8;
end
end
end
VolumenBaja=NLMUpsample2(volumenLR,[2 2 2]);

% 	[Xorig,Yorig,Zorig]=meshgrid(1:64,1:64,1:30);
% 	[Xnuev,Ynuev,Znuev]=meshgrid((0.75:0.5:64.25),(0.75:0.5:64.25),(0.75:0.5:30.25));
% 
% 	VolumenBaja=abs(interp3(Xorig,Yorig,Zorig,volumenLR,Xnuev,Ynuev,Znuev,'cubic'));
%     

end
