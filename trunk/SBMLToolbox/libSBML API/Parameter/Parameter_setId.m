function SBMLParameter = Parameter_setId(SBMLParameter, id)
%
%   Parameter_setId 
%             takes  1) an SBMLParameter structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the parameter with the id set
%
%       SBMLParameter = Parameter_setId(SBMLParameter, 'id')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_setId(SBMLParameter, id)', 'first argument must be an SBML parameter structure'));
elseif (~ischar(id))
    error(sprintf('Parameter_setId(SBMLParameter, id)\n%s', 'second argument must be a string representing the id of the parameter'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Parameter_setId(SBMLParameter, id)', 'no id field in a level 1 model'));    
end;

SBMLParameter.id = id;
