function Unit = Unit_create(varargin)
%
%   Unit_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a unit structure of the required level
%               (default level = 2)
%
%       Unit = Unit_create
%    OR Unit = Unit_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Unit_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'Unit_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help Unit_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'kind', 'exponent', 'scale' };
    Values = {'SBML_UNIT', '', '', '', int32(1), int32(0)};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'kind', 'exponent', 'scale', 'multiplier', 'offset' };
    Values = {'SBML_UNIT', '', '', '', int32(1), int32(0), 1.0, 0.0};
end;

Unit = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_Unit(Unit, sbmlLevel))
    Unit = [];
    warning('Failed to create unit');
end;
