function kind = Unit_getKind(SBMLUnit)
%
%   Unit_getKind 
%             takes an SBMLUnit structure 
%
%             and returns 
%               the kind of the unit as a string
%
%       kind = Unit_getKind(SBMLUnit)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_getKind(SBMLUnit)', 'argument must be an SBML unit structure'));
end;

kind = SBMLUnit.kind;
