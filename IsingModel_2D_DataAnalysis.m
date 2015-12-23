function [ ] = IsingModel_2D_DataAnalysis( Res,Lnum,Tnum)
% Design for data analysis

% order parameter vesrus temperature with different linear dimension
figure(1);
hold on
for i=1:Lnum
    T=zeros(1,Tnum);
    Orderpara=zeros(1,Tnum);
    for j=1:Tnum
        T(j)=Res(i,j).temperature;
        Orderpara(j)=Res(i,j).orderpara;
    end
    plot(T,Orderpara);
end

% susceptibility vesrus temperature with different linear dimension
figure(2);
hold on
for i=1:Lnum
    T=zeros(1,Tnum);
    X=zeros(1,Tnum);
    for j=1:Tnum
        T(j)=Res(i,j).temperature;
        X(j)=Res(i,j).susceptibility;
    end
    plot(T,X);
end
end

