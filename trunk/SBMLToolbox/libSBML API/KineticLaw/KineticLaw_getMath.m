function math = KineticLaw_getMath(SBMLKineticLaw)
%
%   KineticLaw_getMath 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the math of the kineticLaw as a string
%
%       math = KineticLaw_getMath(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_getMath(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'KineticLaw_getMath(SBMLKineticLaw)', 'no math field in a level 1 model'));    
end;

math = SBMLKineticLaw.math;
