function offset = Unit_getOffset(SBMLUnit)
%
%   Unit_getOffset 
%             takes an SBMLUnit structure 
%
%             and returns 
%               the offset of the unit as a double
%
%       offset = Unit_getOffset(SBMLUnit)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_getOffset(SBMLUnit)', 'argument must be an SBML unit structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Unit_getOffset(SBMLUnit)', 'no offset field in a level 1 model'));    
end;

offset = SBMLUnit.offset;
