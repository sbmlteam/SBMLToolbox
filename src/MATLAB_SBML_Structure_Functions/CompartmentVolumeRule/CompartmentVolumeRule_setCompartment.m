function SBMLCompartmentVolumeRule = CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, compartment)
%
%   CompartmentVolumeRule_setCompartment 
%             takes  1) an SBMLCompartmentVolumeRule structure 
%             and    2) a string representing the compartment to be set
%
%             and returns 
%               the compartmentVolumeRule with the compartment set
%
%       SBMLCompartmentVolumeRule = CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, 'compartment')

%  Filename    :   CompartmentVolumeRule_setCompartment.m
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



% check that input is correct
if (~isstruct(SBMLCompartmentVolumeRule))
    error(sprintf('%s\n%s', ...
      'CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule)', ...
      'argument must be an SBML compartmentVolumeRule structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLCompartmentVolumeRule);

if (~isSBML_CompartmentVolumeRule(SBMLCompartmentVolumeRule, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, compartment)', 'first argument must be an SBML compartmentVolumeRule structure'));
elseif (~ischar(compartment))
    error(sprintf('CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, compartment)\n%s', 'second argument must be a string representing the compartment of the compartmentVolumeRule'));
end;

SBMLCompartmentVolumeRule.compartment = compartment;
