function SBMLParameter = Parameter_moveIdToName(SBMLParameter)
%
%   Parameter_moveIdToName 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLParameter = Parameter_moveIdToName(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_moveIdToName(SBMLParameter)', 'argument must be an SBML parameter structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Parameter_moveIdToName(SBMLParameter)', 'no id field in a level 1 model'));    
end;

if (~Parameter_isSetName(SBMLParameter))
    id = Parameter_getId(SBMLParameter);
    SBMLParameter = Parameter_setName(SBMLParameter, id);
    SBMLParameter = Parameter_setId(SBMLParameter, '');
end;
