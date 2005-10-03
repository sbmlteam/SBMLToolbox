function fail = TestGetEquilibrium
% GetEquilibrium takes a SBMLModel 
% and returns 
%           1) an array representing the equilibrium values of each species 
%           2) a structure containing other equilibrium conditions
%                 species - symbolic array of species
%                 initialValues - initial values for each species
%                 equilValues - equilibrium values ( = 0 if not reached)
%                 timeValues - values at time limit
%                 Time - time taken to reach equilibrium
%                 delta_t - time step used
%                 tolerance - tolerance achieved
%                 Time_limit - the time limit on the iterative process
%

fail = 1;