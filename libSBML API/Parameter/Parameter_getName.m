function name = Parameter_getName(SBMLParameter)
%
%   Parameter_getName 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the name of the parameter as a string
%
%       name = Parameter_getName(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_getName(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

name = SBMLParameter.name;
