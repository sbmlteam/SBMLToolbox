function SBMLKineticLaw = KineticLaw_setMathFromFormula(SBMLKineticLaw)
%
%   KineticLaw_setMathFromFormula 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the model with math set to the formula field 
%
%       SBMLKineticLaw = KineticLaw_setMathFromFormula(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_setMathFromFormula(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'KineticLaw_setMathFromFormula(SBMLKineticLaw)', 'no math field in a level 1 model'));    
end;

formula = KineticLaw_getFormula(SBMLKineticLaw);
SBMLKineticLaw = KineticLaw_setMath(SBMLKineticLaw, formula);
