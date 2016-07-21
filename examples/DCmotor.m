function dydt=DCmotor(t,y,SE11,R13,R33,beta,L14,R23,J24,breaks,coeffs)

% STATE VECTOR
%   y(:,1)  shaft momentum
%   y(:,2)  armature flux

% CONSTANT EXCITED
% Constant excited parameters
% SE11=220;R13=0.875;R33=1.75;beta=0.9;L14=0.175;R23=0.066;J24=0.8;

% switch in a torque load at 2.5s 
%  if t>2.5
%      R23=R23*10;
%  end
% 
%  dydt=[-R23/J24 beta/L14;-beta/J24 - R13/L14]*y+[0;SE11];



% SERIES EXCITED
% Series excited parameters
% SE11=220;R13=0.875;R33=1.75;beta=0.0307;L14=0.175;R23=0.066;J24=0.8;
%  breaks=[0 1 1.1 2 2.1 3 3.1 4 4.1 20];coeffs=[1 1 .75 .75 .5 .5 .25 .25 0 0];

% switch out current limiting resistances
%  R13 = 3.5*interp1(breaks,coeffs,t)+ R13;
%  dydt=[-(R23/J24)*y(1)+(beta/L14^2)*y(2)^2;y(2)*(-R13-R33)/L14-(beta/(L14*J24))*y(1)*y(2)+SE11];


% PARALLEL EXCITED
% Parallel excited parameters
% SE11=220;R13=0.875;R33=1.75;beta=0.0307;L14=0.175;R23=0.066;J24=0.8;

% switch in a torque load at 2.5s 
 if t>2.5
     R23=R23*10;
 end

 dydt=[-(R23/J24)*y(1)+(beta*SE11)/(R33*L14)*y(2);y(2)*-R13/L14-(beta*SE11)/(R33*J24)*y(1)+SE11];

% % ---------------------------------------
% % SIMULATION - use in command line

% options=odeset('RelTol',1e-4,'AbsTol',1e-8);
% [t,y]=ode45(@DCmotor,[0 10],[0;0],options,SE11,R13,R33,beta,L14,R23,J24,breaks,coeffs);

% % outputs
% w24=y(:,1)/J24;i14=y(:,2)/L14;t23=y(:,1)*R23/J24; 
% plot(t,w24,'r'); plot(t,i14,'g') ;  plot(t,t23,'b')

end