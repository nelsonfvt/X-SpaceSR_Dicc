function [Xregression]=Rotacion(x,y,z,VectorInterp,vec,I,dirGradiente,volumenGradientesSpline,cantgrad)
angp=vec(:,dirGradiente);
Xregression(1:27,1)=VectorInterp';
            for gradientesAdicionales=1:cantgrad
                ang2=vec(:,I(gradientesAdicionales));
                parche555=double(volumenGradientesSpline(x-2:x+2,y-2:y+2,z-2:z+2,gradientesAdicionales));
                vectorVecinos=Pruebarotacion(x,y,z,angp,ang2,parche555);
                Xregression(1:27,1+gradientesAdicionales)=vectorVecinos';
            end
end
