% Monte Carlo Simulation of 2D Ising Model
%--------------------------------------------------------------------------
% Macrospcopic Parameters of Target System
%--------------------------------------------------------------------------
L=24; % linear dimension
Jkt=0.1; % normalized spin exchange energy, i.e. J/kT
%--------------------------------------------------------------------------
% Control Parameters of Monte Carlo Process
%--------------------------------------------------------------------------
mcsmax=10000; % max number of monte carlo step
n0=1000; % wait steps for establishing system equilibrium
Sample_Interval=100; % step interval between each sample
s=rng(0,'twister'); % use seed as 0 and generator type of Mersenne Twister

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
for mcs=1:mcsmax
    % sweep through the whole lattice
    for i=1:L
        for j=1:L
            % Choose one lattice site
            TargetSpin=Lattice(i,j);
            % Calculate energy difference
            EnergyDiff=Lattice(ip(i),j)+Lattice(im(i),j)+...
                Lattice(i,ip(j))+Lattice(i,im(j));
            EnergyDiff=TargetSpin*EnergyDiff;
            % Choose the random number from [0,1]
            dice=rand;
            % decide flip spin or not
            if dice < W(EnergyDiff/2+3)
                Lattice(i,j)=-TargetSpin;
            end
            % ensure system has reached equilibrium state
            if mcs >= n0
                count=count+1;
                % Sample interval
                if count==Sample_Interval
                    count=0;
                    % analysis part
                end
            end
        end
    end
end