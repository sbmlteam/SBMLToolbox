function Compartment = Compartment_create(varargin)
%
%   Compartment_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a compartment structure of the required level
%               (default level = 2)
%
%       Compartment = Compartment_create
%    OR Compartment = Compartment_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Compartment_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'Compartment_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help Compartment_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'volume', 'units', 'outside', 'isSetVolume' };
    Values = {'SBML_COMPARTMENT', '', '', '', 1, '', '', int32(1)};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'spatialDimensions', 'size', 'units', 'outside', 'constant', 'isSetSize', 'isSetVolume' };
    Values = {'SBML_COMPARTMENT', '', '', '', '',int32(3), 1, '', '', int32(1), int32(1), int32(1)};
end;

Compartment = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_Compartment(Compartment, sbmlLevel))
    Compartment = [];
    warning('Failed to create compartment');
end;