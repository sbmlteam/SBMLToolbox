function SBMLUnit = Unit_setOffset(SBMLUnit, offset)
%
%   Unit_setOffset 
%             takes  1) an SBMLUnit structure 
%             and    2) the offset to be set
%
%             and returns 
%               the unit with the offset set
%
%       SBMLUnit = Unit_setOffset(SBMLUnit, offset)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_setOffset(SBMLUnit, offset)', 'first argument must be an SBML unit structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Unit_setOffset(SBMLUnit, offset)', 'no offset field in a level 1 model'));    
elseif (~isnumeric(offset))
    error(sprintf('%s\n%s', 'Unit_setOffset(SBMLUnit, offset)', 'second argument must be a number representing the offset'));        
end;

SBMLUnit.offset = offset;
