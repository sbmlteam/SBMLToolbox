function Reaction = Reaction_create(varargin)
%
%   Reaction_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a reaction structure of the required level
%               (default level = 2)
%
%       Reaction = Reaction_create
%    OR Reaction = Reaction_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Reaction_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'Reaction_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help Reaction_create'));
end;

warning off all;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'reactant', 'product', 'kineticLaw', 'reversible', 'fast' };
    Values = {'SBML_REACTION', '', '', '', [], [], [], int32(0),  int32(0)};
    reactant = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {});
    product = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {});
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'reactant', 'product', 'modifier', 'kineticLaw', 'reversible', 'fast', 'IsSetFast' };
    Values = {'SBML_REACTION', '', '', '', '', [], [], [], [], int32(0),  int32(-1), int32(0)};
    reactant = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {}, 'stoichiometryMath', {});
    product = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {}, 'stoichiometry', {}, 'denominator', {}), 'stoichiometryMath', {};
    modifier = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'species', {});
end;

Reaction = cell2struct(Values, SBMLfieldnames, 2);
Reaction = setfield(Reaction, 'product', product);
Reaction = setfield(Reaction, 'reactant', reactant);
if (sbmlLevel == 2)
    Reaction = setfield(Reaction, 'modifier', modifier);
end;
if (sbmlLevel == 1)
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'value', {}, 'units', {}, 'isSetValue', {});
    kineticLaw = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'formula', {}, 'parameter', parameter, 'timeUnits', {}, 'substanceUnits', {});
else
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, 'constant', {}, 'isSetValue', {});
    kineticLaw = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'formula', {}, 'math', {}, 'parameter', parameter, 'timeUnits', {}, 'substanceUnits', {});
end;

% kineticLaw = setfield(kineticLaw, 'parameter', parameter);
Reaction = setfield(Reaction, 'kineticLaw', kineticLaw);

warning on all;

%check created structure is appropriate
if (~isSBML_Reaction(Reaction, sbmlLevel))
    Reaction = [];
    warning('Failed to create reaction');
end;
