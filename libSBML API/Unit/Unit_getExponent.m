function exponent = Unit_getExponent(SBMLUnit)
%
%   Unit_getExponent 
%             takes an SBMLUnit structure 
%
%             and returns 
%               the exponent of the unit as an integer
%
%       exponent = Unit_getExponent(SBMLUnit)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_getExponent(SBMLUnit)', 'argument must be an SBML unit structure'));
end;

exponent = SBMLUnit.exponent;
