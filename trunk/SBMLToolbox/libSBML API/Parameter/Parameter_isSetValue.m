function value = Parameter_isSetValue(SBMLParameter)
%
%   Parameter_isSetValue 
%             takes an SBMLParameter structure 
%
%             and returns the value of the isSetValue field
%               1 if the value has been set 
%               0 otherwise
%
%       value = Parameter_isSetValue(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_isSetValue(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

value = SBMLParameter.isSetValue;
