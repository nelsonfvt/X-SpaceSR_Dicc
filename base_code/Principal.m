clear all
close all

%% Cargar Datos de volumen (Volumen, Dirección gradientes)

% Defina la siguiente información:
subject='A';% 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K'
scanner= 'GE';%
acquisition='st'; %'st' 'sa'
dirGradiente=10;
% Funciones Carga volumen y gradientes, direcciones
[Data,vec,val]=CargarDatos(subject,scanner,acquisition);
[I]=DireccionGradiente(vec,val,Data,dirGradiente);

%% Baja resolución espacial de imágen original y carga demás gradientes
[Xs,Ys,Ts,Gs]=size(Data);
volumenHR=Data(:,:,:,dirGradiente);% VOLUMEN A RECONSTRUIR
[VolumenBaja]=BajaResolucion(volumenHR,Ts,Ys,Xs);%baja resolucion a la 1/2 en cada direccion espacial-->Volmen interpolado
betastot=size(I);  
VolumenInterp=cast(VolumenBaja,'double'); % volumen interpolado
[volumenGradientesSpline]=BajaResolucionGradien(Data,betastot,I); %% Gradientes interpolados
volumenHR=cast(volumenHR,'double');
%% HIPÓTESIS PRINCIPAL

xIterativoHR=zeros(Xs,Ys,Ts);
indiceVecindario=1;

for z=30:35
    for y=45:65
        for x=45:65
            [VectorOriginal,VectorInterp]=VectoresOrg_Spl(volumenHR,VolumenInterp,x,y,z);
            %vectorVecindarioB=VectorInterp;
            %vectorVecindarioA=VectorOriginal;
            medORG=mean(VectorOriginal);
            stdORG=std(VectorOriginal);
            Coef=stdORG/medORG;
            
            Yregression=VectorOriginal';
            
            [Xregression]=Rotacion(x,y,z,VectorInterp,vec,I,dirGradiente,volumenGradientesSpline);
                     
            [beta]=mvregress(Xregression,Yregression,'algorithm','cwls');
        
            betas(indiceVecindario,:)=beta;
                 indiceVecindario=indiceVecindario+1;
            
            %% reconstrucción
%             
%             %%reconstruir
%             suma=beta(1)*VectorInterp;
%             for gradientesAdicionales=1:15
%                 [VectorInterpGradientes]=VectoresGradSpl(volumenGradientesSpline,x,y,z,gradientesAdicionales)
%                 suma=suma+((beta(gradientesAdicionales+1)*VectorInterpGradientes));
%             end
%                                    
%             
%             xIterativoHR(x,y-1,z)=suma(1);
%             xIterativoHR(x-1,y-1,z)=suma(2);
%             xIterativoHR(x+1,y-1,z)=suma(3);
%             xIterativoHR(x-1,y,z)=suma(4);
%             xIterativoHR(x-1,y-1,z+1)=suma(5);
%             xIterativoHR(x+1,y-1,z+1)=suma(6);
%             xIterativoHR(x-1,y,z-1)=suma(7);
%             xIterativoHR(x+1,y,z-1)=suma(8);
%             xIterativoHR(x+1,y-1,z-1)=suma(9);
%             xIterativoHR(x-1,y-1,z-1)=suma(10);
%             xIterativoHR(x,y-1,z-1)=suma(11);
%             xIterativoHR(x,y,z-1)=suma(12);
%             xIterativoHR(x,y-1,z+1)=suma(13);
%             xIterativoHR(x,y,z)=suma(14);
%             xIterativoHR(x,y+1,z)=suma(15);
%             xIterativoHR(x+1,y+1,z)=suma(16);
%             xIterativoHR(x-1,y+1,z)=suma(17);
%             xIterativoHR(x+1,y,z)=suma(18);
%             xIterativoHR(x+1,y+1,z-1)=suma(19);
%             xIterativoHR(x-1,y+1,z-1)=suma(20);
%             xIterativoHR(x+1,y,z+1)=suma(21);
%             xIterativoHR(x-1,y,z+1)=suma(22);
%             xIterativoHR(x-1,y+1,z+1)=suma(23);
%             xIterativoHR(x+1,y+1,z+1)=suma(24);
%             xIterativoHR(x,y+1,z+1)=suma(25);
%             xIterativoHR(x,y,z+1)=suma(26);
%             xIterativoHR(x,y+1,z-1)=suma(27);
            
        end
    end
end      
            
% orden=kmeans(betas,20);
% grupos(:,:)=betas;               
% grupos(:,17)=orden;   
            
  



