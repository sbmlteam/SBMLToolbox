function RateRule = RateRule_create(varargin)
%
%   RateRule_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a rateRule structure of the required level
%               (default level = 2)
%
%       RateRule = RateRule_create
%    OR RateRule = RateRule_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'RateRule_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'RateRule_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help RateRule_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_RATE_RULE', '', '', 'rate', '', '', '', '', '', ''};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_RATE_RULE', '', '', '', '', '', '', '', ''};
end;

RateRule = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_RateRule(RateRule, sbmlLevel))
    RateRule = [];
    warning('Failed to create rateRule');
end;
