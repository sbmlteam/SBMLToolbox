function SpeciesConcentrationRule = SpeciesConcentrationRule_create(varargin)
%
%   SpeciesConcentrationRule_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a speciesConcentrationRule structure of the required level
%               (default level = 2)
%
%       SpeciesConcentrationRule = SpeciesConcentrationRule_create
%    OR SpeciesConcentrationRule = SpeciesConcentrationRule_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'SpeciesConcentrationRule_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'SpeciesConcentrationRule_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help SpeciesConcentrationRule_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_SPECIES_CONCENTRATION_RULE', '', '', '', '', '', '', '', '', ''};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_SPECIES_CONCENTRATION_RULE', '', '', '', '', '', '', '', ''};
end;

SpeciesConcentrationRule = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_SpeciesConcentrationRule(SpeciesConcentrationRule, sbmlLevel))
    SpeciesConcentrationRule = [];
    warning('Failed to create speciesConcentrationRule');
end;
