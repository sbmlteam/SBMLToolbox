function Parameter = Parameter_create(varargin)
%
%   Parameter_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a parameter structure of the required level
%               (default level = 2)
%
%       Parameter = Parameter_create
%    OR Parameter = Parameter_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Parameter_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'Parameter_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help Parameter_create'));
end;

warning off all;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'value', 'units', 'isSetValue' };
    Values = {'SBML_PARAMETER', '', '', '', 0/0, '',  int32(0)};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'value', 'units', 'constant', 'isSetValue' };
    Values = {'SBML_PARAMETER', '', '', '', '',0/0, '', int32(1), int32(0)};
end;

Parameter = cell2struct(Values, SBMLfieldnames, 2);
warning on all;