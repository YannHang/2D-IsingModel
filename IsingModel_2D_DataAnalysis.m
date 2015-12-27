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
xlabel('$T/T_c$','interpreter','latex');
ylabel('$m_L$','interpreter','latex');
title('Order parameter $m$ Versus Reduced temperature $T/T_c$','interpreter','latex');
grid on
grid minor
legend('L=10','L=20','L=30','L=40','L=50','L=60','L=70','L=80');
% susceptibility versus temperature with different linear dimension
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
xlabel('$T/T_c$','interpreter','latex');
ylabel('$\chi_L$','interpreter','latex');
title('Susceptibility $\chi$ Versus Reduced temperature $T/T_c$','interpreter','latex');
grid on
grid minor
legend('L=10','L=20','L=30','L=40','L=50','L=60','L=70','L=80');
% fourth-cumulant versus temperature with different linear dimension
figure(3);
hold on
for i=1:Lnum
    T=zeros(1,Tnum);
    U=zeros(1,Tnum);
    for j=1:Tnum
        T(j)=Res(i,j).temperature;
        U(j)=Res(i,j).fourth_cumulant;
    end
    plot(T,U);
end
xlabel('$T/T_c$','interpreter','latex');
ylabel('$U_L$','interpreter','latex');
title('Cumulant $U_L$ Versus Reduced temperature $T/T_c$','interpreter','latex');
grid on
grid minor
legend('L=10','L=20','L=30','L=40','L=50','L=60','L=70','L=80');
% fourth-cumulant ratio versus temperature with different ratio
T=zeros(1,Tnum);
for i=1:Tnum
    T(i)=Res(1,i).temperature;
end
% 80/10
Ratio_1=zeros(1,Tnum);
for i=1:Tnum
    Ratio_1(i)=Res(Lnum,i).fourth_cumulant/Res(1,i).fourth_cumulant;
end
% 70/20
Ratio_2=zeros(1,Tnum);
for i=1:Tnum
    Ratio_2(i)=Res(Lnum-1,i).fourth_cumulant/Res(2,i).fourth_cumulant;
end
% 60/30
Ratio_3=zeros(1,Tnum);
for i=1:Tnum
    Ratio_3(i)=Res(Lnum-2,i).fourth_cumulant/Res(3,i).fourth_cumulant;
end
% 50/40
Ratio_4=zeros(1,Tnum);
for i=1:Tnum
    Ratio_4(i)=Res(Lnum-3,i).fourth_cumulant/Res(4,i).fourth_cumulant;
end
figure(4)
hold on
plot(T,Ratio_1);
plot(T,Ratio_2);
plot(T,Ratio_3);
plot(T,Ratio_4);

xlabel('$T/T_c$','interpreter','latex');
ylabel('$U_L/U_{L^\prime}$','interpreter','latex');
title('Cumulant ratio $U_L/U_{L^\prime}$ Versus Reduced temperature $T/T_c$','interpreter','latex');
grid on
grid minor
legend('L/L^\prime=80/10','L/L^\prime=70/20','L/L^\prime=60/30','L/L^\prime=50/40');
end
