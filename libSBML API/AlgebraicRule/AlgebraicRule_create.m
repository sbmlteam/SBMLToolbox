function AlgebraicRule = AlgebraicRule_create(varargin)
%
%   AlgebraicRule_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a algebraicRule structure of the required level
%               (default level = 2)
%
%       AlgebraicRule = AlgebraicRule_create
%    OR AlgebraicRule = AlgebraicRule_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'AlgebraicRule_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'AlgebraicRule_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help AlgebraicRule_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_ALGEBRAIC_RULE', '', '', 'rate', '', '', '', '', '', ''};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_ALGEBRAIC_RULE', '', '', '', '', '', '', '', ''};
end;

AlgebraicRule = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_AlgebraicRule(AlgebraicRule, sbmlLevel))
    AlgebraicRule = [];
    warning('Failed to create algebraicRule');
end;
