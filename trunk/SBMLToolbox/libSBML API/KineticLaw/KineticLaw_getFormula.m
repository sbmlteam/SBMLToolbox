function formula = KineticLaw_getFormula(SBMLKineticLaw)
%
%   KineticLaw_getFormula 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the formula of the kineticLaw as a string
%
%       formula = KineticLaw_getFormula(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_getFormula(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

formula = SBMLKineticLaw.formula;
