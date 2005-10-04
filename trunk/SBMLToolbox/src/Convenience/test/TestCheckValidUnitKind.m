function fail = TestCheckValidUnitKind
%   CheckValidUnitKind 
%             takes a string representing a unit kind
%             and returns 1 if it is valid 0 otherwise
%
%
%       value = CheckValidUnitKind('kind')

m = TranslateSBML('test1.xml');

kind1 = m.unitDefinition(1).unit.kind;
kind2 = m.unitDefinition(2).unit(2).kind;
kind3 = m.unitDefinition(2).unit(3).kind;
kind4 = m.unitDefinition(3).id;

fail = TestFunction('CheckValidUnitKind', 1, 1, kind1, 1);
fail = fail + TestFunction('CheckValidUnitKind', 1, 1, kind2, 1);
fail = fail + TestFunction('CheckValidUnitKind', 1, 1, kind3, 1);
fail = fail + TestFunction('CheckValidUnitKind', 1, 1, kind4, 0);
