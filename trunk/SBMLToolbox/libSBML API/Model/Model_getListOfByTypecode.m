function array = Model_getListOfByTypecode(SBMLModel, SBMLTypecode)
%
%   Model_getListOfByTypecode 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing an SBMLTypecode
%
%             and returns 
%               an array of SBML structures of the given type defined within the model
%
%       array = Model_getListOfByTypecode(SBMLModel, 'SBMLTypecode')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfByTypecode(SBMLModel, SBMLTypecode)', 'first argument must be an SBML model structure'));
elseif (~CheckTypecode(SBMLTypecode))
    error(sprintf('%s\n%s', 'Model_getListOfByTypecode(SBMLModel, SBMLTypecode)', 'second argument must be a string representing an SBML typecode'));   
end;

switch (SBMLTypecode)
    case 'SBML_FUNCTION_DEFINITION'
        array = SBMLModel.functionDefinition;
    case 'SBML_UNIT_DEFINITION'
        array = SBMLModel.unitDefinition;
    case 'SBML_COMPARTMENT'
        array = SBMLModel.compartment;
    case 'SBML_SPECIES'
        array = SBMLModel.species;
    case 'SBML_PARAMETER'
        array = SBMLModel.parameter;
    case {'SBML_ASSIGNMENT_RULE', 'SBML_ALGEBRAIC_RULE', 'SBML_RATE_RULE', 'SBML_SPECIES_CONCENTRATION_RULE', 'SBML_COMPARTMENT_VOLUME_RULE', 'SBML_PARAMETER_RULE'}
        array = SBMLModel.rule;
    case 'SBML_REACTION'
        array = SBMLModel.reaction;
    case 'SBML_EVENT'
        array = SBMLModel.event;
    otherwise
        array = [];
end;

%------------------------------------------------------------------------------------
function value = CheckTypecode(SBMLTypecode)
%
%   CheckTypecode 
%             takes a string representing an SBMLTypecode
%             and returns 1 if it is a valid typecode and 0 otherwise
%
%       value = CheckTypecode('SBMLTypecode')

ValidTypecodes = {'SBML_COMPARTMENT', 'SBML_EVENT', 'SBML_FUNCTION_DEFINITION', 'SBML_PARAMETER', 'SBML_REACTION', 'SBML_SPECIES', ...
    'SBML_UNIT_DEFINITION', 'SBML_ASSIGNMENT_RULE', 'SBML_ALGEBRAIC_RULE', 'SBML_RATE_RULE', 'SBML_SPECIES_CONCENTRATION_RULE', ...
    'SBML_COMPARTMENT_VOLUME_RULE', 'SBML_PARAMETER_RULE'};


value = 1;

if (~ischar(SBMLTypecode))
    value = 0;
elseif (~ismember(SBMLTypecode, ValidTypecodes))
    value = 0;
end;