function SBMLKineticLaw = KineticLaw_setFormulaFromMath(SBMLKineticLaw)
%
%   KineticLaw_setFormulaFromMath 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the model with formula set to the math field 
%
%       SBMLKineticLaw = KineticLaw_setFormulaFromMath(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_setFormulaFromMath(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'KineticLaw_setFormulaFromMath(SBMLKineticLaw)', 'no math field in a level 1 model'));    
end;

math = KineticLaw_getMath(SBMLKineticLaw);
SBMLKineticLaw = KineticLaw_setFormula(SBMLKineticLaw, math);
