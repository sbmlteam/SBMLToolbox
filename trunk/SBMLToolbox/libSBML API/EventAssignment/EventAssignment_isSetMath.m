function value = EventAssignment_isSetMath(SBMLEventAssignment)
%
%   EventAssignment_isSetMath 
%             takes an SBMLEventAssignment structure 
%
%             and returns 
%               1 if the math has been set 
%               0 otherwise
%
%       value = EventAssignment_isSetMath(SBMLEventAssignment)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel))
    error(sprintf('%s\n%s', 'EventAssignment_isSetMath(SBMLEventAssignment)', 'argument must be an SBML eventAssignment structure'));
end;

value = ~isempty(SBMLEventAssignment.math);
