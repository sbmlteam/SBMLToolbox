function value = KineticLaw_isSetMath(SBMLKineticLaw)
%
%   KineticLaw_isSetMath 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               1 if the math has been set 
%               0 otherwise
%
%       value = KineticLaw_isSetMath(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_isSetMath(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'KineticLaw_isSetMath(SBMLKineticLaw)', 'no math field in a level 1 model'));    
end;

value = ~isempty(SBMLKineticLaw.math);
