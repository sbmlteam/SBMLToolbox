function value = Parameter_isSetUnits(SBMLParameter)
%
%   Parameter_isSetUnits 
%             takes an SBMLParameter structure 
%
%             and returns 
%               1 if the units has been set 
%               0 otherwise
%
%       value = Parameter_isSetUnits(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_isSetUnits(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

value = ~isempty(SBMLParameter.units);
