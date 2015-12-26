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
end

