function Model = Model_create(varargin)
%
%   Model_create 
%             optionally takes an SBML level
%             optionally takes an SBML version
%
%             and returns 
%               a Model structure of the required level and version
%               (default level = 2 version = 3)
%
%       Model = Model_create
%    OR Model = Model_create(sbmlLevel)
%    OR Model = Model_create(sbmlLevel, sbmlVersion)


%  Filename    :   Model_create.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   09-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):


%default level = 2
%default version = 3
sbmlLevel = 2;
sbmlVersion = 3;
if (nargin > 2)
    error(sprintf('%s\n%s\n%s', 'Model_create(sbmlLevel, sbmlVersion)', 'requires either zero, one or two arguments', 'SEE help Model_create'));

elseif (nargin == 2)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Model_create(sbmlLevel, sbmlVersion)', 'first argument must be a valid SBML level i.e. either 1 or 2'));
    elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 1) || (varargin{2} > 3))
        error(sprintf('%s\n%s', 'Model_create(sbmlLevel, sbmlVersion)', 'second argument must be a valid SBML version i.e. either 1, 2 or 3'));
    end;
    sbmlLevel = varargin{1};
    if (sbmlLevel == 1 && varargin{2} == 3)
        error(sprintf('Level - version mismatch\nAllowed combinations are L1V1 L1V2 L2V1 L2V2 or L2V3'));
    else
        sbmlVersion = varargin{2};
    end;
    
elseif (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Model_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
    
end;

warning off all;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'unitDefinition', 'compartment', 'species', 'parameter', 'rule', 'reaction'};
    Values = {'SBML_MODEL', '', '', int32(1), int32(2), '', [], [], [], [], [], []};

    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, 'exponent',{},  'scale', {});
    unitDefinition = struct( 'typecode', {},  'notes', {},  'annotation', {},  'name', {},  'unit', unit);

    compartment = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'volume', {},  'units', {},  'outside', {},  'isSetVolume', {});

    species = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'compartment', {},  'initialAmount', {},  'units', {},  'boundaryCondition', {},  'charge', {},  'isSetInitialAmount', {},  'isSetCharge', {});
    
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'value', {}, 'units', {}, 'isSetValue', {});

    rule = struct('typecode', {},  'notes', {},  'annotation', {},  'type', {},  'formula', {},  'variable', {},  'species', {},  'Model', {},  'name', {},  'units', {});

    reactant = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {});
    product = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {});
    kineticLaw = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'formula', {}, 'parameter', parameter, 'timeUnits', {}, 'substanceUnits', {});
    reaction = struct('typecode', {},  'notes', {},  'annotation', {},  'name', {},  'reactant', reactant,  'product', product,  'kineticLaw', kineticLaw,  'reversible', {},  'fast', {});

else
  if (sbmlVersion == 1)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'id', 'functionDefinition', 'unitDefinition', 'compartment', 'species', 'parameter', 'rule', 'reaction', 'event'};
    Values = {'SBML_MODEL', '', '', '', int32(2), int32(1), '', '', [], [], [], [], [], [], [], []};

    unit = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'kind', {}, 'exponent',{},  'scale', {}, 'multiplier', {}, 'offset',{});
    unitDefinition = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'unit', unit);

    functionDefinition = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'math', {});

    compartment = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'spatialDimensions', {},  'size', {},  'units', {},  'outside', {},  'constant', {},  'isSetSize', {},  'isSetVolume', {});

    species = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'compartment', {},  'initialAmount', {},  'initialConcentration', {},  'substanceUnits', {},  'spatialSizeUnits', {},  'hasOnlySubstanceUnits', {},   'boundaryCondition', {},  'charge', {},  'constant', {},  'isSetInitialAmount', {},  'isSetInitialConcentration', {},  'isSetCharge', {});

    parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, 'constant', {}, 'isSetValue', {});
     
    rule = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'formula', {},  'variable', {},  'species', {},  'compartment', {},  'name', {},  'units', {});

    reactant = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {}, 'stoichiometryMath', {});
    product = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {}, 'stoichiometryMath', {});
    modifier = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'species', {});
    kineticLaw = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'formula', {}, 'math', {}, 'parameter', parameter, 'timeUnits', {}, 'substanceUnits', {});
    reaction = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'reactant', reactant,  'product', product,  'modifier', modifier,  'kineticLaw', kineticLaw,  'reversible', {},  'fast', {},  'isSetFast', {});

    eventAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'variable', {}, 'math', {});
    event = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'trigger', {},  'delay', {},  'timeUnits', {},  'eventAssignment', eventAssignment);

  elseif (sbmlVersion == 2)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'id', 'functionDefinition', ...
      'unitDefinition', 'compartmentType', 'speciesType', 'compartment', 'species', 'parameter', 'initialAssignment', 'rule', ...
      'constraint', 'reaction', 'event'};
    Values = {'SBML_MODEL', '', '', '', int32(2), int32(1), '', '', [], [], [], [], [], [], [], [], [], [], [], []};
    
    unit = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'kind', {}, 'exponent',{},  'scale', {}, 'multiplier', {});
    unitDefinition = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'unit', unit);

    functionDefinition = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {}, 'sboTerm', int32(-1),  'name', {},  'id', {},  'math', {});

    compartmentType = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {});
    
    speciesType = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {});
    
    compartment = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  ...
      'compartmentType', {}, 'spatialDimensions', {},  'size', {},  'units', {},  'outside', {},  'constant', {},  'isSetSize', {},  'isSetVolume', {});

    species = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  ...
      'speciesType', {}, 'compartment', {},  'initialAmount', {},  'initialConcentration', {},  'substanceUnits', {},  'spatialSizeUnits', {},  'hasOnlySubstanceUnits', {},   'boundaryCondition', {},  'charge', {},  'constant', {},  'isSetInitialAmount', {},  'isSetInitialConcentration', {},  'isSetCharge', {});

    parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, ...
      'constant', {}, 'sboTerm', int32(-1), 'isSetValue', {});
    
    initialAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'symbol', {}, 'sboTerm', int32(-1), 'math', {});
     
    rule = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'sboTerm', int32(-1), 'formula', {},  'variable', {},  'species', {},  'compartment', {},  'name', {},  'units', {});

    constraint = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'math', {}, 'message', {});
    
    reactant = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'id', {}, 'name', {}, ...
      'sboTerm', int32(-1), 'stoichiometry', {}, 'stoichiometryMath', {});
    product = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'id', {}, 'name', {}, ...
      'sboTerm', int32(-1), 'stoichiometry', {}, 'stoichiometryMath', {});
    modifier = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'id', {}, 'name', {}, 'sboTerm', int32(-1));
    kineticLaw = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'formula', {}, 'math', {}, 'parameter', parameter, ...
      'sboTerm', int32(-1));
    reaction = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'reactant', reactant,  ...
      'product', product,  'modifier', modifier,  'kineticLaw', kineticLaw,  'reversible', {},  'fast', {},  'sboTerm', int32(-1), 'isSetFast', {});

    eventAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'variable', {}, 'sboTerm', int32(-1), 'math', {});
    event = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'name', {},  'id', {},  'trigger', {},  'delay', {}, ...
      'timeUnits', {},  'sboTerm', int32(-1), 'eventAssignment', eventAssignment);
    
  elseif (sbmlVersion == 3)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'id', 'functionDefinition', ...
      'unitDefinition', 'compartmentType', 'speciesType', 'compartment', 'species', 'parameter', 'initialAssignment', 'rule', ...
      'constraint', 'reaction', 'event'};
    Values = {'SBML_MODEL', '', '', '', int32(2), int32(1), '', '', [], [], [], [], [], [], [], [], [], [], [], []};
    
    unit = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'kind', {}, 'exponent',{},  'scale', {}, 'multiplier', {});
    unitDefinition = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {}, 'sboTerm', int32(-1),  'name', {},  'id', {},  'unit', unit);

    functionDefinition = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {}, 'sboTerm', int32(-1),  'name', {},  'id', {},  'math', {});

    compartmentType = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'name', {}, 'id', {});
    
    speciesType = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'name', {}, 'id', {});
    
    compartment = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'sboTerm', int32(-1), 'name', {},  'id', {},  ...
      'compartmentType', {}, 'spatialDimensions', {},  'size', {},  'units', {},  'outside', {},  'constant', {},  'isSetSize', {},  'isSetVolume', {});

    species = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'sboTerm', int32(-1), 'name', {},  'id', {},  ...
      'speciesType', {}, 'compartment', {},  'initialAmount', {},  'initialConcentration', {},  'substanceUnits', {},  ...
      'hasOnlySubstanceUnits', {},   'boundaryCondition', {},  'charge', {},  'constant', {},  'isSetInitialAmount', {},  'isSetInitialConcentration', {},  'isSetCharge', {});

    parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'name', {}, 'id', {}, 'value', {}, 'units', {}, ...
      'constant', {}, 'isSetValue', {});

    initialAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'symbol', {}, 'math', {});
     
    rule = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'sboTerm', int32(-1), 'formula', {},  'variable', {},  'species', {},  'compartment', {},  'name', {},  'units', {});

    constraint = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'math', {}, 'message', {});
    
    reactant = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'species', {}, 'id', {}, 'name', {}, ...
      'stoichiometry', {}, 'stoichiometryMath', {});
    product = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'species', {}, 'id', {}, 'name', {}, ...
      'stoichiometry', {}, 'stoichiometryMath', {});
    modifier = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'species', {}, 'id', {}, 'name', {});
    kineticLaw = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'formula', {}, 'math', {}, ...
      'parameter', parameter);
    reaction = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'sboTerm', int32(-1), 'name', {},  'id', {},  'reactant', reactant,  ...
      'product', product,  'modifier', modifier,  'kineticLaw', kineticLaw,  'reversible', {},  'fast', {},  'isSetFast', {});

    trigger = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'math', {});
    delay = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'math', {});
    eventAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', int32(-1), 'variable', {}, 'math', {});
    event = struct('typecode', {},  'metaid', {}, 'notes', {},  'annotation', {},  'sboTerm', int32(-1), 'name', {},  'id', {},  ...
      'trigger', trigger,  'delay', delay, 'eventAssignment', eventAssignment);
  end;
end;

Model = cell2struct(Values, SBMLfieldnames, 2);
Model = setfield(Model, 'unitDefinition', unitDefinition);
Model = setfield(Model, 'compartment', compartment);
Model = setfield(Model, 'species', species);
Model = setfield(Model, 'parameter', parameter);
Model = setfield(Model, 'rule', rule);
Model = setfield(Model, 'reaction', reaction);

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
