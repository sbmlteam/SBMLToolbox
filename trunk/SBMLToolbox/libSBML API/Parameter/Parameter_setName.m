function SBMLParameter = Parameter_setName(SBMLParameter, name)
%
%   Parameter_setName 
%             takes  1) an SBMLParameter structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the parameter with the name set
%
%       SBMLParameter = Parameter_setName(SBMLParameter, 'name')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_setName(SBMLParameter, name)', 'first argument must be an SBML parameter structure'));
elseif (~ischar(name))
    error(sprintf('Parameter_setName(SBMLParameter, name)\n%s', 'second argument must be a string representing the name of the parameter'));
end;

SBMLParameter.name = name;
