function id = Parameter_getId(SBMLParameter)
%
%   Parameter_getId 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the id of the parameter as a string
%
%       id = Parameter_getId(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_getId(SBMLParameter)', 'argument must be an SBML parameter structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Parameter_getId(SBMLParameter)', 'no id field in a level 1 model'));    
end;

id = SBMLParameter.id;
