function value = Parameter_isSetId(SBMLParameter)
%
%   Parameter_isSetId 
%             takes an SBMLParameter structure 
%
%             and returns 
%               1 if the id has been set 
%               0 otherwise
%
%       value = Parameter_isSetId(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_isSetId(SBMLParameter)', 'argument must be an SBML parameter structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Parameter_isSetId(SBMLParameter)', 'no id field in a level 1 model'));    
end;

value = ~isempty(SBMLParameter.id);
