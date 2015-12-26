function IsingModel_2D_ScalingAnalysis(Res,Lnum,Tnum)
% 2D Ising Model

% order parameter finite-size scaling
figure(1)
hold on
for i=1:Lnum
    T=zeros(1,Tnum);
    Orderpara=zeros(1,Tnum);
    for j=1:Tnum
        T(j)=Res(i,j).temperature;
        Orderpara(j)=Res(i,j).orderpara;
    end
    T=(T-1)*Res(i,1).length;
    Orderpara=Orderpara*Res(i,1).length^(1/8);
    scatter(T,Orderpara,8);
end

% susceptibility finite-size scaling
figure(2)
hold on
for i=1:Lnum
    T=zeros(1,Tnum);
    Suscep=zeros(1,Tnum);
    for j=1:Tnum
        T(j)=Res(i,j).temperature;
        Suscep(j)=Res(i,j).susceptibility;
    end
    T=(T-1)*Res(i,1).length;
    Suscep=Suscep*Res(i,1).length^(1/8);
    scatter(T,Suscep,8);
end

end