function value = Parameter_getValue(SBMLParameter)
%
%   Parameter_getValue 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the value of the parameter as a double
%
%       value = Parameter_getValue(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_getValue(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

value = SBMLParameter.value;
