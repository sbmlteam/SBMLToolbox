function SBMLUnit = Unit_setExponent(SBMLUnit, exponent)
%
%   Unit_setExponent 
%             takes  1) an SBMLUnit structure 
%             and    2) an integer representing the exponent to be set
%
%             and returns 
%               the unit with the exponent set
%
%       SBMLUnit = Unit_setExponent(SBMLUnit, exponent)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_setExponent(SBMLUnit, exponent)', 'first argument must be an SBML model structure'));
elseif (~isIntegralNumber(exponent))
    error(sprintf('Unit_setExponent(SBMLUnit, exponent)\n%s', 'second argument must be an integer representing the exponent of the unit'));
end;

SBMLUnit.exponent = int32(exponent);
