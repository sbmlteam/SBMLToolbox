function UnitDefinition = UnitDefinition_create(varargin)
%
%   UnitDefinition_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a unitDefinition structure of the required level
%               (default level = 2)
%
%       UnitDefinition = UnitDefinition_create
%    OR UnitDefinition = UnitDefinition_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'UnitDefinition_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'UnitDefinition_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help UnitDefinition_create'));
end;

warning off all;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'unit'};
    Values = {'SBML_UNIT_DEFINITION', '', '', '', []};
    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, 'exponent',{},  'scale', {})
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'unit'};
    Values = {'SBML_UNIT_DEFINITION', '', '', '', '', []};
    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, 'exponent',{},  'scale', {}, 'multiplier', {}, 'offset',{});

end;

UnitDefinition = cell2struct(Values, SBMLfieldnames, 2);
UnitDefinition = setfield(UnitDefinition, 'unit', unit);

warning on all;

%check created structure is appropriate
if (~isSBML_UnitDefinition(UnitDefinition, sbmlLevel))
    UnitDefinition = [];
    warning('Failed to create unitDefinition');
end;
