function KineticLaw = KineticLaw_create(varargin)
%
%   KineticLaw_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a kineticLaw structure of the required level
%               (default level = 2)
%
%       KineticLaw = KineticLaw_create
%    OR KineticLaw = KineticLaw_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'KineticLaw_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'KineticLaw_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help KineticLaw_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'parameter', 'timeUnits', 'substanceUnits'};
    Values = {'SBML_KINETIC_LAW', '', '', '', [], '', ''};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'math', 'parameter', 'timeUnits', 'substanceUnits'};
    Values = {'SBML_KINETIC_LAW', '', '', '', '', [], '', ''};
end;

KineticLaw = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_KineticLaw(KineticLaw, sbmlLevel))
    KineticLaw = [];
    warning('Failed to create kineticLaw');
end;
