function SBMLParameter = Parameter_setValue(SBMLParameter, value)
%
%   Parameter_setValue 
%             takes  1) an SBMLParameter structure 
%             and    2) a double representing the value to be set
%
%             and returns 
%               the parameter with the value set
%
%       SBMLParameter = Parameter_setValue(SBMLParameter, value)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_setValue(SBMLParameter, value)', 'first argument must be an SBML parameter structure'));
end;

SBMLParameter.value = value;
SBMLParameter.isSetValue = 1;
