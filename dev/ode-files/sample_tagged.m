function f
% time is in minutes
tspan=[0 300]; 
% SBML - begin init conds
xzero=[0;0];
% SBML - end init conds
% parameter values  (Time is in minutes)
% SBML - begin constants
a=0.1*60;
b=0.0058*60;
c=0.006*60;
d=0.000192*60;
% SBML - end constants
[t,y]=ode45(@g,tspan,xzero);
figure
plot(t,y(:,2))

% SBML - begin ode declaration
function y=g(t,x)
% SBML - end ode declaration

% SBML - begin ode function
y=[a-b*x(1); c*x(1)-d*x(2)];
% SBML - end ode function
end


end


