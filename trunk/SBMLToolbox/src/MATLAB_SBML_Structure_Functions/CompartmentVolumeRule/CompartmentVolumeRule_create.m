function CompartmentVolumeRule = CompartmentVolumeRule_create()
%
%   CompartmentVolumeRule_create 
%
%             and returns 
%               a compartmentVolumeRule structure (level 1 ONLY)
%
%       CompartmentVolumeRule = CompartmentVolumeRule_create

%  Filename    :   CompartmentVolumeRule_create.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->



%default level = 1
sbmlLevel = 1;
if (nargin > 0)
    error(sprintf('%s\n%s\n%s', 'CompartmentVolumeRule_create()', ...
      'requires no arguments', 'SEE help CompartmentVolumeRule_create'));
end;

SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', ...
  'variable', 'species', 'compartment', 'name', 'units'};
Values = {'SBML_COMPARTMENT_VOLUME_RULE', '', '', '', '', '', '', '', '', ''};

CompartmentVolumeRule = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_CompartmentVolumeRule(CompartmentVolumeRule, sbmlLevel))
    CompartmentVolumeRule = [];
    warning('Failed to create compartmentVolumeRule');
end;
