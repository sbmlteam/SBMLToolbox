function SBMLParameter = Parameter_moveNameToId(SBMLParameter)
%
%   Parameter_moveNameToId 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLParameter = Parameter_moveNameToId(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_moveNameToId(SBMLParameter)', 'argument must be an SBML parameter structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Parameter_moveNameToId(SBMLParameter)', 'no id field in a level 1 model'));    
end;

if (~Parameter_isSetId(SBMLParameter))
    name = Parameter_getName(SBMLParameter);
    SBMLParameter = Parameter_setId(SBMLParameter, name);
    SBMLParameter = Parameter_setName(SBMLParameter, '');
end;
