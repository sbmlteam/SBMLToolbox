function math = EventAssignment_getMath(SBMLEventAssignment)
%
%   EventAssignment_getMath 
%             takes an SBMLEventAssignment structure 
%
%             and returns 
%               the math of the eventAssignment as a string
%
%       math = EventAssignment_getMath(SBMLEventAssignment)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel))
    error(sprintf('%s\n%s', 'EventAssignment_getMath(SBMLEventAssignment)', 'argument must be an SBML eventAssignment structure'));
end;

math = SBMLEventAssignment.math;
