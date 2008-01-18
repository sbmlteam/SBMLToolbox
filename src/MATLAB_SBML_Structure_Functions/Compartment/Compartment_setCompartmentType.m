function SBMLCompartment = Compartment_setCompartmentType(SBMLCompartment, compartmentType)
%
%   Compartment_setCompartmentType 
%             takes  1) an SBMLCompartment structure 
%             and    2) an string representing the compartmentType to be set
%
%             and returns 
%               the compartment with the compartmentType set
%
%       SBMLCompartment = Compartment_setCompartmentType(SBMLCompartment, compartmentType)

%  Filename    :   Compartment_setCompartmentType.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->



% check that input is correct
if (~isstruct(SBMLCompartment))
    error(sprintf('%s\n%s', ...
      'Compartment_setCompartmentType(SBMLCompartment, compartmentType)', ...
      'argument must be an SBML compartment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLCompartment);

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel, sbmlVersion))
  error(sprintf('%s\n%s', ...
    'Compartment_setCompartmentType(SBMLCompartment, compartmentType)', ...
    'first argument must be an SBML compartment structure'));
elseif (~ischar(compartmentType))
    error(sprintf('%s\n%s', ...
      'Compartment_setCompartmentType(SBMLCompartment, compartmentType)', ...
      'second argument must be a string representing the compartmentType'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'Compartment_setCompartmentType(SBMLCompartment, compartmentType)',  ...
      'compartmentType field only in level 2 version 2/3 model'));    
end;

SBMLCompartment.compartmentType = compartmentType;
