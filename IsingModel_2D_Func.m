function [ m,X,U ] = IsingModel_2D_Func( T,L, MCSMAX,INTERVAL,N0)
% Input:
% T:Temperature normalized with T_c
% L:Lattice linear dimension
% MCSMAX: max monte carlo step number
% INTERVAL: sample interval in terms of monte carlo step
% N0: equilibrium wanting monte carlo step
% Output:
% m:Order Parameter
% X:Susceptibility
% U:Fourth moment of magnetization

%==========================================================================
% Monte Carlo Simulation of 2D Ising Model
%==========================================================================

%--------------------------------------------------------------------------
% Macrospcopic Parameters of Target System
%--------------------------------------------------------------------------
Jkt_c=0.5*log(1+sqrt(2)); % exact value of 2D Ising Model
Jkt=Jkt_c/T; % normalized spin exchange energy, i.e. J/kT
N=L*L; % number of spins
m=0; % order parameter
X=0; % susceptibility
U=0; % fourth-order cumulant of order parameter
%--------------------------------------------------------------------------
% Control Parameters of Monte Carlo Process
%--------------------------------------------------------------------------
mcsmax=MCSMAX; % max number of monte carlo step
n0=N0; % wait steps for establishing system equilibrium
Sample_Interval=INTERVAL; % Sample Interval
s=rng(0,'twister'); % use seed as 0 and generator type of Mersenne Twister
%--------------------------------------------------------------------------
% Output Data Preallocation
%--------------------------------------------------------------------------
SampleTime=zeros(1,ceil(mcsmax/Sample_Interval));
OrderPara=zeros(1,ceil(mcsmax/Sample_Interval));
OrderPara_second=zeros(1,ceil(mcsmax/Sample_Interval));
OrderPara_fourth=zeros(1,ceil(mcsmax/Sample_Interval));
%--------------------------------------------------------------------------
% Lattice Initialization
%--------------------------------------------------------------------------
Lattice=zeros(L,L);
% Initial Configuration
% Here set as all spin down
for i=1:L
    for j=1:L
        Lattice(i,j)=-1;
    end
end
% Initialize order parameter
m=sum(sum(Lattice))/N;
%--------------------------------------------------------------------------
% Periodic Boundary Condition
%--------------------------------------------------------------------------
ip=zeros(1,L);
im=zeros(1,L);
for i=1:L
    ip(i)=i+1;
    im(i)=i-1;
end
ip(L)=1;
im(1)=L;
%--------------------------------------------------------------------------
% Energy difference table
%--------------------------------------------------------------------------
% There are only five possible energy differences in 2D nearest neighbering 
% Ising Model: -8J,-4J,0,4J,8J
% Choose transition probability W in the form of Metropolis function
% i.e. W=\min{1,exp(-\frac{\Delta H}{k_B T})}

% \Delta H = -8J
W(1)=1;
% \Delta H = -4J
W(2)=1;
% \Delta H = 0
W(3)=1;
% \Delta H = 4J
W(4)=exp(-4*Jkt);
% \Delta H = 8J
W(5)=exp(-8*Jkt);
%--------------------------------------------------------------------------
% Monte Carlo Simulation
%--------------------------------------------------------------------------
count=0;% used for counting current steps from last measurement
Sample_count=0; % used for counting current sample number
for mcs=1:mcsmax
    % sweep through the whole lattice
    for i=1:L
        for j=1:L
            % Choose one lattice site
            TargetSpin=Lattice(i,j);
            % Calculate energy difference
            EnergyDiff=Lattice(ip(i),j)+Lattice(im(i),j)+Lattice(i,ip(j))+Lattice(i,im(j));
            EnergyDiff=TargetSpin*EnergyDiff;
            % Choose the random number from [0,1]
            dice=rand;
            % decide flip spin or not
            if dice < W(EnergyDiff/2+3)
                Lattice(i,j)=-TargetSpin;
            end
        end
    end
    % ensure system has reached equilibrium state
    if mcs >= n0
       count=count+1;
       % Sample interval
         if count==Sample_Interval
            count=0;
            % analysis part
            Sample_count=Sample_count+1;
            SampleTime(Sample_count)=mcs;
            orderparameter=abs(sum(sum(Lattice)))/N;
            % calculate order parameter m=<|s|>
            OrderPara(Sample_count)=orderparameter;
            % calculate square of order parameter 
            orderparameter=orderparameter*orderparameter;
            OrderPara_second(Sample_count)=orderparameter;
            % calculate fourth power of order parameter
            orderparameter=orderparameter*orderparameter;
            OrderPara_fourth(Sample_count)=orderparameter;
         end
    end
end
% order parameter
m=sum(OrderPara)/Sample_count;
% susceptibility
OrderPara_second_moment=sum(OrderPara_second)/Sample_count;
X=(OrderPara_second_moment-m^2)*N;
% fourth cumulant
U=1-(sum(OrderPara_fourth)/Sample_count)/(3*OrderPara_second_moment^2);
end

