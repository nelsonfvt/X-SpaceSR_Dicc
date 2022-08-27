
function vectorVecinosl=Pruebarotacion(x,y,z,angp,ang2,parche555)
%% PRUEBA BIEN 
cruz=cross(ang2,angp);
punto=acos(dot(angp,ang2)/(norm(angp)*norm(ang2)));
% B=imrotate3(parche555,punto,[cruz(1),0,0],'nearest');
volumenGradientesSpline=imrotate3(parche555,punto,[cruz(1),cruz(2),cruz(3)],'nearest');
vectorVecinos(1:27)=0;


    x=3;
    y=3;
    z=3;
vectorVecinos(1)=volumenGradientesSpline(x,y-1,z);
vectorVecinos(2)=volumenGradientesSpline(x-1,y-1,z);
vectorVecinos(3)=volumenGradientesSpline(x+1,y-1,z);
vectorVecinos(4)=volumenGradientesSpline(x-1,y,z);
vectorVecinos(5)=volumenGradientesSpline(x-1,y-1,z+1);
vectorVecinos(6)=volumenGradientesSpline(x+1,y-1,z+1);
vectorVecinos(7)=volumenGradientesSpline(x-1,y,z-1);
vectorVecinos(8)=volumenGradientesSpline(x+1,y,z-1);
vectorVecinos(9)=volumenGradientesSpline(x+1,y-1,z-1);
vectorVecinos(10)=volumenGradientesSpline(x-1,y-1,z-1);
vectorVecinos(11)=volumenGradientesSpline(x,y-1,z-1);
vectorVecinos(12)=volumenGradientesSpline(x,y,z-1);
vectorVecinos(13)=volumenGradientesSpline(x,y-1,z+1);
vectorVecinos(14)=volumenGradientesSpline(x,y,z);
vectorVecinos(15)=volumenGradientesSpline(x,y+1,z);
vectorVecinos(16)=volumenGradientesSpline(x+1,y+1,z);
vectorVecinos(17)=volumenGradientesSpline(x-1,y+1,z);
vectorVecinos(18)=volumenGradientesSpline(x+1,y,z);
vectorVecinos(19)=volumenGradientesSpline(x+1,y+1,z-1);
vectorVecinos(20)=volumenGradientesSpline(x-1,y+1,z-1);
vectorVecinos(21)=volumenGradientesSpline(x+1,y,z+1);
vectorVecinos(22)=volumenGradientesSpline(x-1,y,z+1);
vectorVecinos(23)=volumenGradientesSpline(x-1,y+1,z+1);
vectorVecinos(24)=volumenGradientesSpline(x+1,y+1,z+1);
vectorVecinos(25)=volumenGradientesSpline(x,y+1,z+1);
vectorVecinos(26)=volumenGradientesSpline(x,y,z+1);
vectorVecinos(27)=volumenGradientesSpline(x,y+1,z-1);
vectorVecinosl=vectorVecinos(:);
end



