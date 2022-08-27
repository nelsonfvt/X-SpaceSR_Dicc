function [volumenGradientesSpline]=BajaResolucionGradien(Data,betastot,I)

for gradientesAdicionales=1:betastot

volumenHR=Data(:,:,:,I(gradientesAdicionales));
volumenHRd=cast(volumenHR,'double');
[Xs,Ys,Ts,Gs]=size(Data);
[VolumenBaja]=BajaResolucion(volumenHR,Ts,Ys,Xs);
%NORMAL BAJA RESOLCION
%volumenGradientesSpline(:,:,:,gradientesAdicionales)=VolumenBaja;

%PRUEBA CON DICCIONARIO
volumenGradientesSpline(:,:,:,gradientesAdicionales)=VolumenBaja;

end
end
