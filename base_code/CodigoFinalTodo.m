
clear all
close all

 %for cuentasuj=1:2%10
% Ruta='/home/jennifer/Documentos/TESIS_DEFINITIVO/SUPERESOLUCION_ULTIMO/imagenantesdePrisma';% CASA
% Sufij='_brain.nii.gz';
% w=['A','B','C','D','E','F','G','I','J','K'];
% ALLa=[Ruta,w(cuentasuj),Sufij];
% imgorgnegro=load_untouch_nii(ALLa); 
% imgorgnegroo=double(imgorgnegro.img);

%for contador1=4:5%30
% Cargar Datos de volumen (Volumen, DirecciÃ³n gradientes)
%Defina la siguiente informaciÃ³n:
subject='B';%w(cuentasuj);%'K';% 'B' 'C' 'D' 'E' 'F' 'G' 'I' 'J' 'K'
scanner= 'GE';%GE%Prisma %Connectom
acquisition='st'; 
dirGradiente=10;%contador1;
%Funciones Carga volumen y gradientes, direcciones
[Data,vec,val,A]=CargarDatos(subject,scanner,acquisition);
[I]=DireccionGradiente(vec,val,Data,dirGradiente);
 
% Baja resoluciÃ³n espacial de imÃ¡gen original y carga demÃ¡s gradientes
[Xs,Ys,Ts,Gs]=size(Data);
volumenHR=Data(:,:,:,dirGradiente);% VOLUMEN A RECONSTRUIR
volumenHR=cast(volumenHR,'double');

%VOLUMEN SUBIDOS CON DIFERENTES MeTODOS
 [VolumenBajaSpline]=BajaResolucion(volumenHR,Ts+1,Ys,Xs+1);%baja resolucion a la 1/2 en cada direccion espacial-->Volmen interpolado
 [VolumenBajaMj]=BajaResolucionMj(volumenHR,Ts,Ys,Xs);
 [VolumenBajaLin]=BajaResolucionL(volumenHR,Ts,Ys,Xs);
 
betastot=size(I);  
VolumenInterp=cast(VolumenBajaSpline,'double'); % volumen interpolado


%% DICCIONARIO 6*6*6
xIterativoHR=zeros(Xs,Ys,Ts);
indiceVecindario=1;
cont=1;
D(:,:)=zeros(27,10000);
indiceVecindario=1;

%reconstruir vol
t=1;
xIterativoHRorg=zeros(128,128,Ts);  
xIterativoHRLi=zeros(128,128,Ts);
xIterativoHRmetod=zeros(128,128,Ts);  
xIterativoHRspl=zeros(128,128,Ts);  
xIterativoHRmj=zeros(128,128,Ts);
    
            %varr=1;
for z=6:6:54
    for y=6:6:122
        for x=6:6:122
            
            Vhr=volumenHR(x-2:x+3,y-2:y+3,z-2:z+3);
            Vhr=reshape(Vhr,[216 1]);
                        
            medORG=mean(Vhr);
            stdORG=std(Vhr);
            Coef=stdORG/medORG;
            %varr=varr+1;
            
           if medORG<1200 && medORG>200 && Coef>0.29 %% para general electric
            
           %%if medORG<120 && medORG>30 && Coef>0.2 %%PRISMA
            Vsp=VolumenBajaSpline(x-2:x+3,y-2:y+3,z-2:z+3);
            Vsp=reshape(Vsp,[216 1]);
            VectorSp(:,indiceVecindario)=Vsp;
       
            Vmj=VolumenBajaMj(x-2:x+3,y-2:y+3,z-2:z+3);
            Vmj=reshape(Vmj,[216 1]);
            VectorMJ(:,indiceVecindario)=Vmj;
            
            VL=VolumenBajaLin(x-2:x+3,y-2:y+3,z-2:z+3);
            VL=reshape(VL,[216 1]);
            VectorL(:,indiceVecindario)=VL;
           
            Vhr=volumenHR(x-2:x+3,y-2:y+3,z-2:z+3);
            Vhr=reshape(Vhr,[216 1]);
            VectorHr(:,indiceVecindario)=double(Vhr);            

            VecOrg=reshape(Vhr,[6 6 6]);
            xIterativoHRorg(x-2:x+3,y-2:y+3,z-2:z+3)=VecOrg;
            
            
            cantgrad=29; %definir cantidad de gradientes a usar;
         
         for gradientesAdicionales=1:cantgrad

            VGhr=Data(x-2:x+3,y-2:y+3,z-2:z+3,I(gradientesAdicionales)); %% para este si toca tener en cuenta la posición del gradiente mas cercano
            VGhr=reshape(VGhr,[216 1]);
            VectorGhr(:,gradientesAdicionales)=VGhr;
  
          end
              
            Dhr(:,cont:cont+(cantgrad-1))=VectorGhr(:,:);   
           
            cont=cont+cantgrad;
            indiceVecindario=indiceVecindario+1; 
            
            else 
                
            Vsp1=VolumenBajaSpline(x-2:x+3,y-2:y+3,z-2:z+3);
            Vsp1=reshape(Vsp1,[216 1]);
            Vmj=VolumenBajaMj(x-2:x+3,y-2:y+3,z-2:z+3);
            Vmj=reshape(Vmj,[216 1]);
%             Vhr=volumenHR(x-2:x+3,y-2:y+3,z-2:z+3);
%             Vhr=reshape(Vhr,[216 1]);
            VL=VolumenBajaLin(x-2:x+3,y-2:y+3,z-2:z+3);
            VL=reshape(VL,[216 1]);
            
            
            VecSpl1=reshape(Vsp1,[6 6 6]);   
            %VecOrg=reshape(Vhr(:,t),[6 6 6]);
            VecSpl=reshape(Vsp1(:,t),[6 6 6]);
            VecMj=reshape(Vmj(:,t),[6 6 6]);
            VecLi=reshape(VL(:,t),[6 6 6]);
            
            xIterativoHRmetod(x-2:x+3,y-2:y+3,z-2:z+3)=VecSpl1;
            %xIterativoHRorg(x-2:x+3,y-2:y+3,z-2:z+3)=VecOrg;
            xIterativoHRLi(x-2:x+3,y-2:y+3,z-2:z+3)=VecLi;
            xIterativoHRspl(x-2:x+3,y-2:y+3,z-2:z+3)=VecSpl;
            xIterativoHRmj(x-2:x+3,y-2:y+3,z-2:z+3)=VecMj;
            end
        end
    end
end


%% CREA DICCIONARIO
Nparches=length(VectorHr(1,:));
Nvoxls=216;
tic
[WHr,DDHr,K1]=CreaDiccionario(Nparches,Nvoxls,Dhr,VectorHr,cantgrad,13);
toc



%% PROGRAMA RECONSTRUCCIÓN
%bajaresolucion del diccionario
for cont=1:length(DDHr)
DiccLR5=reshape(DDHr(:,cont),[6 6 6]); %Vuelvo un parche cubito de 6*6*6
[volLR1]=bajaresol_dicc(DiccLR5); %le bajo la resoluciÃ³n
DDLR(:,cont)=reshape(volLR1,[27 1]);
end

for contador=1:length(VectorHr(1,:))

 Parcheprueba=reshape(VectorSp(:,contador),[6 6 6]); %saco un parche de prueba y lo vuelvo cubito
 [volLR2]=bajaresol_dicc(Parcheprueba); %bajo resoluciÃ³n 
  XLR(:,contador)=reshape(volLR2,[27 1]);
 
 % WNueLi = sparseapprox(XLR(:,contador),DDLR, 'mexOMP','tnz',15, 'tre',0.00000000001);
   WNueLi = sparseapprox(XLR(:,contador),DDLR, 'mexOMP','tnz',13);
  ParcRec(:,contador)=abs(DDHr*WNueLi); 
end

%% RECONSTRUIR EL VOLUMEN
t=1;
for z=6:6:54
    for y=6:6:122
        for x=6:6:122
            Vhr=volumenHR(x-2:x+3,y-2:y+3,z-2:z+3);
            Vhr=reshape(Vhr,[216 1]);
                        
            medORG=mean(Vhr);
            stdORG=std(Vhr);
            Coef=stdORG/medORG;
            
             if medORG<1200 && medORG>200 && Coef>0.29
            %if medORG<120 && medORG>30 && Coef>0.2 %%PRISMA
    VecOrg=reshape(VectorHr(:,t),[6 6 6]);
    VecSpl=reshape(VectorSp(:,t),[6 6 6]);
    VecMj=reshape(VectorMJ(:,t),[6 6 6]);
    VecLi=reshape(VectorL(:,t),[6 6 6]);
    Vecrec=reshape(ParcRec(:,t),[6 6 6]);
    
    
    
    xIterativoHRorg(x-2:x+3,y-2:y+3,z-2:z+3)=VecOrg;
    xIterativoHRLi(x-2:x+3,y-2:y+3,z-2:z+3)=VecLi;
    xIterativoHRmetod(x-2:x+3,y-2:y+3,z-2:z+3)=Vecrec;
    xIterativoHRspl(x-2:x+3,y-2:y+3,z-2:z+3)=VecSpl;
    xIterativoHRmj(x-2:x+3,y-2:y+3,z-2:z+3)=VecMj;
    
   t=t+1;
            end
           
        end
    end
end






%% REGULARIZACION!!!!!!!!!<<<<...------<<<<<<
%<<<<<<<<<<<<<<<<<<<<<---------------<<<<<<<<<<<<<<<<<<
%<<<<<<<<<<<<<<----------------<<<<<<<<<<<<<<<<

Xt=xIterativoHRmetod;
for xqw=1:4
%% VOLUMEN BAJA DEL MÉTODO
for z=1:Ts/2%1:30
for y=1:Ys/2%1:64
for x=1:Xs/2%1:64
	volumenbaja(x,y,z)=Xt(2*x,2*y,2*z);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)+Xt(2*x-1,2*y-1,2*z);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)+Xt(2*x-1,2*y,2*z);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)+Xt(2*x,2*y-1,2*z);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)+Xt(2*x,2*y,2*z-1);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)+Xt(2*x-1,2*y-1,2*z-1);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)+Xt(2*x-1,2*y,2*z-1);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)+Xt(2*x,2*y-1,2*z-1);
	volumenbaja(x,y,z)=volumenbaja(x,y,z)/8;
end
end
end

[Xorig,Yorig,Zorig]=meshgrid(1:64,1:64,1:30);
[Xnuev,Ynuev,Znuev]=meshgrid((0.75:0.5:64.25),(0.75:0.5:64.25),(0.75:0.5:30.25));
Volsp2=interp3(Xorig,Yorig,Zorig,volumenbaja,Xnuev,Ynuev,Znuev,'spline');

for z=1:Ts/2%1:30
for y=1:Ys/2%1:64
for x=1:Xs/2%1:64
	volumenbaja2(x,y,z)=Volsp2(2*x,2*y,2*z);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)+Volsp2(2*x-1,2*y-1,2*z);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)+Volsp2(2*x-1,2*y,2*z);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)+Volsp2(2*x,2*y-1,2*z);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)+Volsp2(2*x,2*y,2*z-1);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)+Volsp2(2*x-1,2*y-1,2*z-1);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)+Volsp2(2*x-1,2*y,2*z-1);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)+Volsp2(2*x,2*y-1,2*z-1);
	volumenbaja2(x,y,z)=volumenbaja2(x,y,z)/8;
end
end
end

%% VOLUMEN ORIGINAL QUITANDO MUESTRAS
Volsp22=xIterativoHRorg;
for z=1:Ts/2%1:30
for y=1:Ys/2%1:64
for x=1:Xs/2%1:64
	volumenbajaORG(x,y,z)=Volsp22(2*x,2*y,2*z);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)+Volsp22(2*x-1,2*y-1,2*z);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)+Volsp22(2*x-1,2*y,2*z);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)+Volsp22(2*x,2*y-1,2*z);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)+Volsp22(2*x,2*y,2*z-1);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)+Volsp22(2*x-1,2*y-1,2*z-1);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)+Volsp22(2*x-1,2*y,2*z-1);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)+Volsp22(2*x,2*y-1,2*z-1);
	volumenbajaORG(x,y,z)=volumenbajaORG(x,y,z)/8;
end
end
end

%% resto el volumen

volresta=volumenbajaORG-volumenbaja2;

%% subo de resolución con lineal

	[Xorig,Yorig,Zorig]=meshgrid(1:64,1:64,1:30);
	[Xnuev,Ynuev,Znuev]=meshgrid((0.75:0.5:64.25),(0.75:0.5:64.25),(0.75:0.5:30.25));

	Volresta2=interp3(Xorig,Yorig,Zorig,volresta,Xnuev,Ynuev,Znuev,'spline');
    
%% sumo los de alta
Volfinal=abs(Volresta2+Xt);
Xt=Volfinal;
end
Xt=imgaussfilt3(Xt, 0.45);%0.45

RESOL2=[1.8 1.8 2.4];
% 
% img1=make_nii(xIterativoHRorg,RESOL2);
% save_nii(img1,'imagenantesdePrismaK.nii');

imgorgnegro=load_untouch_nii('/home/jennifer/Documentos/TESIS_DEFINITIVO/SUPERESOLUCION_ULTIMO/imagenantesdeB_brain.nii.gz');
imgorgnegroo=double(imgorgnegro.img);
% % imgorgnegro=load_untouch_nii('/home/jennifer/Documentos/TESIS_DEFINITIVO/SUPERESOLUCION_ULTIMO/imagenorg_brain.nii.gz');
% % imgorgnegroo=double(imgorgnegro.img);

Mascara=zeros(128,128,60);

for z=1:60
    for y=1:128
        for x=1:128
            
            if imgorgnegroo(x,y,z) < 1
                Mascara(x,y,z) = 0;
            else
                Mascara(x,y,z) = 1;
            end 
        end
    end
end


imgspline=xIterativoHRspl.*Mascara;
imgorg= xIterativoHRorg.*Mascara;
imgLi=xIterativoHRLi.*Mascara;
imgMj=xIterativoHRmj.*Mascara;
imgfinal=Xt.*Mascara;




 PSNR(contador1,1)=psnr(imgfinal,imgorg,1028);%OrgyMetodo
 PSNR(contador1,2)=psnr(imgLi,imgorg,1028);%Orgylin
 PSNR(contador1,3)=psnr(imgspline,imgorg,1028);%OrgySpline
 PSNR(contador1,4)=psnr(imgMj,imgorg,1028);%OrgyMj

  PSNR2(contador1,1)=psnr(imgfinal,imgorg,4096);%OrgyMetodo
 PSNR2(contador1,2)=psnr(imgLi,imgorg,4096);%Orgylin
 PSNR2(contador1,3)=psnr(imgspline,imgorg,4096);%OrgySpline
 PSNR2(contador1,4)=psnr(imgMj,imgorg,4096);%OrgyMj
 
 SSIM(contador1,1)=ssim(imgfinal,imgorg);%OrgyMetodo
 SSIM(contador1,2)=ssim(imgLi,imgorg);
 SSIM(contador1,3)=ssim(imgspline,imgorg);%OrgySpline
 SSIM(contador1,4)=ssim(imgMj,imgorg);%OrgyMj

 volfinales{contador1}=imgfinal;
volfinorg{contador1}=imgorg;
 clearvars -except contador1 PSNR PSNR2 SSIM volfinorg volfinales imgorgnegroo cuentasuj w

%end



Rr='Prisma_';
Suj='.mat';
ALLa=[Rr,w(cuentasuj),Suj];
save(ALLa)


clearvars -except cuentasuj
close all
%end
