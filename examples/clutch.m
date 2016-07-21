function dydt=clutch(t,y,breaks,coeffs,I23,I33,R34,SE21)
%R24=10; % constant engagement
R24=interp1(breaks,coeffs,t,'linear','extrap'); % engage gradually and disengage
dydt=[-R24/I23 R24/I33;R24/I23 (-R24-R34)/I33]*y+[SE21;0];

% increase clutch engagement and re-run simulation
% breaksCL=[0 2 4 20 21 25];coeffsCL=[0 0 10 10 0 0];J23=0.3;J33=0.6;R34=0.2;SE21=20;
end

% % COMMAND LINE --------------------
% % clutch simulation parameters
% options=odeset('RelTol',1e-4,'AbsTol',1e-8);
% breaksCL=[0 2 4 20 21 25];coeffsCL=[0 0 0.1 0.1 0 0];J23=0.3;J33=0.6;R34=0.2;SE21=20;
% [t,y]=ode45(@clutch,[0 25],[0.1;0],options,breaksCL,coeffsCL,J23,J33,R34,SE21);
%
% % calculate ang. vel. outputs
% w23=y(:,1)/J23;w33=y(:,2)/J33;
% nslip=100*w33./w23;
% hold on 
% plot(t,w33,'b-'); plot(t,w23,'r-') ; plot(t,nslip,'g-')

% % calculate torque outputs
% T24=interp1(breaksCL,coeffsCL,t,'linear','extrap').*(w23-w33);
% T34=R34*w33;
% figure
% hold on
% plot(t,T24,'k'); plot(t,T34,'k--');