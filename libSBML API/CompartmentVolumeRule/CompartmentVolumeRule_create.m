function CompartmentVolumeRule = CompartmentVolumeRule_create(varargin)
%
%   CompartmentVolumeRule_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a compartmentVolumeRule structure of the required level
%               (default level = 2)
%
%       CompartmentVolumeRule = CompartmentVolumeRule_create
%    OR CompartmentVolumeRule = CompartmentVolumeRule_create(sbmlLevel)

%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'CompartmentVolumeRule_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'CompartmentVolumeRule_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help CompartmentVolumeRule_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_COMPARTMENT_VOLUME_RULE', '', '', '', '', '', '', '', '', ''};
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_COMPARTMENT_VOLUME_RULE', '', '', '', '', '', '', '', ''};
end;

CompartmentVolumeRule = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_CompartmentVolumeRule(CompartmentVolumeRule, sbmlLevel))
    CompartmentVolumeRule = [];
    warning('Failed to create compartmentVolumeRule');
end;
