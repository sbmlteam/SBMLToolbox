function parameter = KineticLaw_getParameter(SBMLKineticLaw, number)
%
%   KineticLaw_getParameter 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) a number n
%
%             and returns 
%               the nth parameter structure defined within the kineticLaw
%
%       parameter = KineticLaw_getParameter(SBMLKineticLaw, number)

% get level
sbmlLevel = 2;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct


if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_getParameter(SBMLKineticLaw, number)', 'first argument must be an SBML kineticLaw structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'KineticLaw_getParameter(SBMLKineticLaw, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLKineticLaw.parameter))
    parameter = [];
else
    parameter = SBMLKineticLaw.parameter(number);
end;
