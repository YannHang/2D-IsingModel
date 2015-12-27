% This script is designed for analysing 2D Ising Model
% linear dimension
L=[10 20 30 40 50 60 70 80];
% temperature
T=linspace(0.9,1.1,201);
Res=struct('length',0,'temperature',0,'orderpara',0,'susceptibility',0,'fourth_cumulant',0);

for i=1:length(L)
    for j=1:length(T)
        Res(i,j).length=L(i);
        Res(i,j).temperature=T(j);
        [ Res(i,j).orderpara,Res(i,j).susceptibility,Res(i,j).fourth_cumulant ] = IsingModel_2D_Func( T(j),L(i), 201000,20,1000);
    end
end
save Res
IsingModel_2D_DataAnalysis(Res,length(L),length(T));
IsingModel_2D_ScalingAnalysis(Res,length(L),length(T));