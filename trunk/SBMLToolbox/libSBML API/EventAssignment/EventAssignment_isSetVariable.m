function value = EventAssignment_isSetVariable(SBMLEventAssignment)
%
%   EventAssignment_isSetVariable 
%             takes an SBMLEventAssignment structure 
%
%             and returns 
%               1 if the variable has been set 
%               0 otherwise
%
%       value = EventAssignment_isSetVariable(SBMLEventAssignment)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel))
    error(sprintf('%s\n%s', 'EventAssignment_isSetVariable(SBMLEventAssignment)', 'argument must be an SBML eventAssignment structure'));
end;

value = ~isempty(SBMLEventAssignment.variable);
