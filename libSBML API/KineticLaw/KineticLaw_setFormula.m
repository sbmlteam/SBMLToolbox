function SBMLKineticLaw = KineticLaw_setFormula(SBMLKineticLaw, formula)
%
%   KineticLaw_setFormula 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) a string representing the formula to be set
%
%             and returns 
%               the kineticLaw with the formula set
%
%       SBMLKineticLaw = KineticLaw_setFormula(SBMLKineticLaw, 'formula')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_setFormula(SBMLKineticLaw, formula)', 'first argument must be an SBML kineticLaw structure'));
elseif (~ischar(formula))
    error(sprintf('KineticLaw_setFormula(SBMLKineticLaw, formula)\n%s', 'second argument must be a string representing the formula of the kineticLaw'));
end;

SBMLKineticLaw.formula = formula;
