function SBMLParameter = Parameter_unsetName(SBMLParameter)
%
%   Parameter_unsetName 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the parameter with the name unset
%               (i.e. name = '')
%
%       SBMLParameter = Parameter_unsetName(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_unsetName(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

SBMLParameter.name = '';
