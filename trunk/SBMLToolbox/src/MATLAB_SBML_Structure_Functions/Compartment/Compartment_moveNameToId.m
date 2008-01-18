function SBMLCompartment = Compartment_moveNameToId(SBMLCompartment)
%
%   Compartment_moveNameToId 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLCompartment = Compartment_moveNameToId(SBMLCompartment)

%  Filename    :   Compartment_moveNameToId.m
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
      'Compartment_moveNameToId(SBMLCompartment)', ...
      'argument must be an SBML compartment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLCompartment);

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Compartment_moveNameToId(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_moveNameToId(SBMLCompartment)', 'no id field in a level 1 model'));    
end;

if (~Compartment_isSetId(SBMLCompartment))
    name = Compartment_getName(SBMLCompartment);
    SBMLCompartment = Compartment_setId(SBMLCompartment, name);
    SBMLCompartment = Compartment_setName(SBMLCompartment, '');
end;
