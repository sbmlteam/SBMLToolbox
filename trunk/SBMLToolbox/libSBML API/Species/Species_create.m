function Species = Species_create(varargin)
%
%   Species_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a species structure of the required level
%               (default level = 2)
%
%       Species = Species_create
%    OR Species = Species_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Species_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'Species_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help Species_create'));
end;

warning off all;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'compartment', 'initialAmount', 'units', 'boundaryCondition', 'charge', 'isSetInitialAmount', 'isSetCharge' };
    Values = {'SBML_SPECIES', '', '', '', '', 0/0, '', int32(0), 0, int32(0), int32(0)};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'compartment', 'initialAmount', 'initialConcentration', 'substanceUnits', 'spatialSizeUnits', 'hasOnlySubstanceUnits',  'boundaryCondition', 'charge', 'constant', 'isSetInitialAmount', 'isSetInitialConcentration', 'isSetCharge'  };
    Values = {'SBML_SPECIES', '', '', '', '', '', 0/0, 0/0, '', '', int32(0),int32(0), 0, int32(0), int32(0), int32(0), int32(0)};
end;

Species = cell2struct(Values, SBMLfieldnames, 2);
warning on all;

%check created structure is appropriate
if (~isSBML_Species(Species, sbmlLevel))
    Species = [];
    warning('Failed to create species');
end;