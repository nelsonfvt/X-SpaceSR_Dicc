function [volLR1]=bajaresol_dicc(Dicc666)

   for z=1:3%1:30
    for y=1:3%1:64
    for x=1:3%1:64
      %  fprintf('%d %d');
	volLR1(x,y,z)=Dicc666(2*x,2*y,2*z);
	volLR1(x,y,z)=volLR1(x,y,z)+Dicc666(2*x-1,2*y-1,2*z);
	volLR1(x,y,z)=volLR1(x,y,z)+Dicc666(2*x-1,2*y,2*z);
	volLR1(x,y,z)=volLR1(x,y,z)+Dicc666(2*x,2*y-1,2*z);
	volLR1(x,y,z)=volLR1(x,y,z)+Dicc666(2*x,2*y,2*z-1);
	volLR1(x,y,z)=volLR1(x,y,z)+Dicc666(2*x-1,2*y-1,2*z-1);
	volLR1(x,y,z)=volLR1(x,y,z)+Dicc666(2*x-1,2*y,2*z-1);
	volLR1(x,y,z)=volLR1(x,y,z)+Dicc666(2*x,2*y-1,2*z-1);
	volLR1(x,y,z)=volLR1(x,y,z)/8;
    end
    end
    end
