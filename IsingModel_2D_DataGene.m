% This script is designed for analysing 2D Ising Model
% linear dimension
L=[5 10 15 20 25 30 40 50];
% temperature
T=linspace(0.8,1.3,18);
Res=struct('length',0,'temperature',0,'orderpara',0,'susceptibility',0,'fourth_cumulant',0);

for i=1:length(L)
    for j=1:length(T)
        Res(i,j).length=L(i);
        Res(i,j).temperature=T(j);
        [ Res(i,j).orderpara,Res(i,j).susceptibility,Res(i,j).fourth_cumulant ] = IsingModel_2D_Func( T(j),L(i), 5500,10,500);
    end
end
save Res
IsingModel_2D_DataAnalysis(Res,length(L),length(T));