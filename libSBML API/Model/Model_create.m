function Model = Model_create(varargin)
%
%   Model_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a model structure of the required level
%               (default level = 2)
%
%       Model = Model_create
%    OR Model = Model_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Model_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'Model_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help Model_create'));
end;

warning off all;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'unitDefinition', 'compartment', 'species', 'parameter', 'rule', 'reaction'};
    Values = {'SBML_MODEL', '', '', 1, 2, '', [], [], [], [], [], []};

    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, 'exponent',{},  'scale', {});
    unitDefinition = struct( 'typecode', {},  'notes', {},  'annotation', {},  'name', {},  'unit', unit);

    compartment = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'volume', {},  'units', {},  'outside', {},  'isSetVolume', {});

    species = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'compartment', {},  'initialAmount', {},  'units', {},  'boundaryCondition', {},  'charge', {},  'isSetInitialAmount', {},  'isSetCharge', {});
    
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'value', {}, 'units', {}, 'isSetValue', {});

    rule = struct('typecode', {},  'notes', {},  'annotation', {},  'type', {},  'formula', {},  'variable', {},  'species', {},  'compartment', {},  'name', {},  'units', {});

    reactant = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {});
    product = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {});
    kineticLaw = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'formula', {}, 'parameter', parameter, 'timeUnits', {}, 'substanceUnits', {});
    reaction = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'reactant', reactant,  'product', product,  'kineticLaw', kineticLaw,  'reversible', {},  'fast', {});

else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'id', 'functionDefinition', 'unitDefinition', 'compartment', 'species', 'parameter', 'rule', 'reaction', 'event'};
    Values = {'SBML_MODEL', '', '', 2, 1, '', '', [], [], [], [], [], [], [], []};

    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, 'exponent',{},  'scale', {}, 'multiplier', {}, 'offset',{});
    unitDefinition = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'id', {},  'unit', unit);

    functionDefinition = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'id', {},  'math', {});

    compartment = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'id', {},  'spatialDimensions', {},  'size', {},  'units', {},  'outside', {},  'constant', {},  'isSetSize', {},  'isSetVolume', {});

    species = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'id', {},  'compartment', {},  'initialAmount', {},  'initialConcentration', {},  'substanceUnits', {},  'spatialSizeUnits', {},  'hasOnlySubstanceUnits', {},   'boundaryCondition', {},  'charge', {},  'constant', {},  'isSetInitialAmount', {},  'isSetInitialConcentration', {},  'isSetCharge', {});

    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, 'constant', {}, 'isSetValue', {});
     
    rule = struct('typecode', {},  'notes', {},  'annotation', {},  'formula', {},  'variable', {},  'species', {},  'compartment', {},  'name', {},  'units', {});

    reactant = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {}, 'stoichiometryMath', {});
    product = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {}), 'stoichiometryMath', {};
    modifier = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {});
    kineticLaw = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'formula', {}, 'math', {}, 'parameter', parameter, 'timeUnits', {}, 'substanceUnits', {});
    reaction = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'id', {},  'reactant', reactant,  'product', product,  'modifier', modifier,  'kineticLaw', kineticLaw,  'reversible', {},  'fast', {},  'IsSetFast', {});

    eventAssignment = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'variable', {}, 'math', {})
    event = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'id', {},  'trigger', {},  'delay', {},  'timeUnits', {},  'eventAssignment', eventAssignment);

end;

Model = cell2struct(Values, SBMLfieldnames, 2);
Model = setfield(Model, 'unitDefinition', unitDefinition);
Model = setfield(Model, 'compartment', compartment);
Model = setfield(Model, 'species', species);
Model = setfield(Model, 'parameter', parameter);
Model = setfield(Model, 'rule', rule);
Model = setfield(Model, 'reaction', reaction);

% Model = setfield(Model, 'reactant', reactant);
if (sbmlLevel == 2)
    Model = setfield(Model, 'functionDefinition', functionDefinition);
    Model = setfield(Model, 'event', event);
end;

warning on all;

%check created structure is appropriate
if (~isSBML_Model(Model))
    Model = [];
    warning('Failed to create model');
end;
