function [Data,vec,val,A]=CargarDatos(subject,scanner,acquisition)
% subject='D';% 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K'
% scanner= 'GE'%
% acquisition='st'; %'st' 'sa'

div='/';
Suf='dwi.nii';
Rut='/home/jennifer/Documentos/TESIS_MAESTRIA/CHALLENGESUPERR2017/';%UMNG

%Rut='/home/jennifer/Documents/CHALLENGE/cdmri_training_data/';% CASA
ALL=[Rut,subject,div,scanner,div,acquisition,div,Suf];
A=load_untouch_nii(ALL);
Data=single(A.img);


LO='.nii';
for L=1:33
    LL=mat2str(L);
    A2=[Rut,subject,div,scanner,div,LL,LO];
   % save_untouch_nii(,A2)
   % niftiwrite(Data(:,:,:,L),A2); 
    nii = make_nii(Data(:,:,:,L));
    save_nii(nii, A2);
end


% CARGAR INFO BVEC Y BVAL  !!!!!OJO CON EL SUJETO Y LA MÁQUINA

%co=fopen('/home/jennifer/Documents/CHALLENGE/cdmri_training_data/A/GE/st/dwi.bvec','r');%CASA
%co=fopen('/home/jennifer/Documentos/TESIS_MAESTRIA/CHALLENGESUPERR2017/A/GE/st/dwi.bvec','r');%UMNG
Rutt='/home/jennifer/Documentos/TESIS_MAESTRIA/CHALLENGESUPERR2017/';
rest='st/dwi.bvec';

co=[Rutt,subject,div,scanner,div,rest];
coo=fopen(co,'r');
sizeA = [3 70];
formatSpec = '%f %f';
vec = fscanf(coo,formatSpec,sizeA);

%co=fopen('/home/jennifer/Documents/CHALLENGE/cdmri_training_data/A/GE/st/dwi.bval','r');%CASA
%co=fopen('/home/jennifer/Documentos/TESIS_MAESTRIA/CHALLENGESUPERR2017/A/GE/st/dwi.bval','r');
Rutt='/home/jennifer/Documentos/TESIS_MAESTRIA/CHALLENGESUPERR2017/';
rest='st/dwi.bval';
cop=[Rutt,subject,div,scanner,div,rest];
coop=fopen(co,'r');

val = fscanf(coop,formatSpec,sizeA);
end
