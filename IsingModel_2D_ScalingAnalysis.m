function IsingModel_2D_ScalingAnalysis(Res,Lnum,Tnum)
% 2D Ising Model

% order parameter finite-size scaling
figure(5)
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
    scatter(T,Orderpara,6);
end
xlabel('$(T-T_c)L^\nu$','interpreter','latex');
ylabel('$m_L L^{\beta/\nu}$','interpreter','latex');
title('Order parameter $m$ Finite-Size Scaling','interpreter','latex');
grid on
grid minor
legend('L=10','L=20','L=30','L=40','L=50','L=60','L=70','L=80');

% susceptibility finite-size scaling
figure(6)
hold on
for i=1:Lnum
    T=zeros(1,Tnum);
    Suscep=zeros(1,Tnum);
    for j=1:Tnum
        T(j)=Res(i,j).temperature;
        Suscep(j)=Res(i,j).susceptibility;
    end
    T=(T-1)*Res(i,1).length;
    Suscep=Suscep*Res(i,1).length^(-7/4);
    scatter(T,Suscep,6);
end
xlabel('$(T-T_c)L^\nu$','interpreter','latex');
ylabel('$\chi_L L^{-\gamma/\nu}$','interpreter','latex');
title('Susceptibility $\chi$ Finite-Size Scaling','interpreter','latex');
grid on
grid minor
legend('L=10','L=20','L=30','L=40','L=50','L=60','L=70','L=80');
end