function value = KineticLaw_isSetFormula(SBMLKineticLaw)
%
%   KineticLaw_isSetFormula 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               1 if the formula has been set 
%               0 otherwise
%
%       value = KineticLaw_isSetFormula(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_isSetFormula(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

value = ~isempty(SBMLKineticLaw.formula);
