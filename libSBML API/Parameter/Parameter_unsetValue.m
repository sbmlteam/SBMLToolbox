function SBMLParameter = Parameter_unsetValue(SBMLParameter)
%
%   Parameter_unsetValue 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the parameter with the value unset
%               (i.e. value = NAN)
%
%       SBMLParameter = Parameter_unsetValue(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_unsetValue(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

warning off all;
SBMLParameter.value = 0/0;
SBMLParameter.isSetValue = 0;
warning on all;
