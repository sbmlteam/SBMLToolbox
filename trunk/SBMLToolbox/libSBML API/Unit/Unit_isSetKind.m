function value = Unit_isSetKind(SBMLUnit)
%
%   Unit_isSetKind 
%             takes an SBMLUnit structure 
%
%             and returns 
%               1 if the kind has been set 
%               0 otherwise
%
%       value = Unit_isSetKind(SBMLUnit)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_isSetKind(SBMLUnit)', 'argument must be an SBML unit structure'));
end;

value = ~isempty(SBMLUnit.kind);
