function SBMLUnit = Unit_setKind(SBMLUnit, kind)
%
%   Unit_setKind 
%             takes  1) an SBMLUnit structure 
%             and    2) a string representing the kind to be set
%
%             and returns 
%               the unit with the kind set
%
%       SBMLUnit = Unit_setKind(SBMLUnit, 'kind')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_setKind(SBMLUnit, kind)', 'first argument must be an SBML unit structure'));
elseif (~ischar(kind))
    error(sprintf('Unit_setKind(SBMLUnit, kind)\n%s', 'second argument must be a string representing the kind of the unit'));
end;

SBMLUnit.kind = kind;
