function SBMLKineticLaw = KineticLaw_setMath(SBMLKineticLaw, math)
%
%   KineticLaw_setMath 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) a string representing the math to be set
%
%             and returns 
%               the kineticLaw with the math set
%
%       SBMLKineticLaw = KineticLaw_setMath(SBMLKineticLaw, 'math')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_setMath(SBMLKineticLaw, math)', 'first argument must be an SBML kineticLaw structure'));
elseif (~ischar(math))
    error(sprintf('KineticLaw_setMath(SBMLKineticLaw, math)\n%s', 'second argument must be a string representing the math of the kineticLaw'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'KineticLaw_setMath(SBMLKineticLaw, math)', 'no math field in a level 1 model'));    
end;

SBMLKineticLaw.math = math;
