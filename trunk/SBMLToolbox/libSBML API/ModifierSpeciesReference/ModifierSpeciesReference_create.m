function ModifierSpeciesReference = ModifierSpeciesReference_create
%
%   ModifierSpeciesReference_create 
%             returns 
%               a modifierSpeciesReference structure
%
%       ModifierSpeciesReference = ModifierSpeciesReference_create

%default level = 2
sbmlLevel = 2;
if (nargin > 0)
    error(sprintf('%s\n%s\n%s', 'ModifierSpeciesReference_create(sbmlLevel)', 'requires no arguments', 'SEE help ModifierSpeciesReference_create'));
end;

SBMLfieldnames = {'typecode', 'notes', 'annotation', 'species'};
Values = {'SBML_MODIFIER_SPECIES_REFERENCE', '', '', ''};

ModifierSpeciesReference = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_ModifierSpeciesReference(ModifierSpeciesReference, sbmlLevel))
    ModifierSpeciesReference = [];
    warning('Failed to create modifierSpeciesReference');
end;
