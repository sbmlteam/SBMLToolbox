function SpeciesReference = SpeciesReference_create(varargin)
%
%   SpeciesReference_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a speciesreference structure of the required level
%               (default level = 2)
%
%       SpeciesReference = SpeciesReference_create
%    OR SpeciesReference = SpeciesReference_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'SpeciesReference_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'SpeciesReference_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help SpeciesReference_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'species', 'stoichiometry', 'denominator' };
    Values = {'SBML_SPECIES_REFERENCE', '', '', '', int32(1), int32(1)};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'species', 'stoichiometry', 'denominator', 'stoichiometryMath' };
    Values = {'SBML_SPECIES_REFERENCE', '', '', '', 1, int32(1), ''};
end;

SpeciesReference = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_SpeciesReference(SpeciesReference, sbmlLevel))
    SpeciesReference = [];
    warning('Failed to create speciesreference');
end;
