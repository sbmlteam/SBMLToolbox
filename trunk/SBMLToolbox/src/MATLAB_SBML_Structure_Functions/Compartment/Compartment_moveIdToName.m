function SBMLCompartment = Compartment_moveIdToName(SBMLCompartment)
%
%   Compartment_moveIdToName 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLCompartment = Compartment_moveIdToName(SBMLCompartment)

%  Filename    :   Compartment_moveIdToName.m
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
      'Compartment_getCompartmentType(SBMLCompartment)', ...
      'argument must be an SBML compartment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLCompartment);

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Compartment_moveIdToName(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_moveIdToName(SBMLCompartment)', 'no id field in a level 1 model'));    
end;

if (~Compartment_isSetName(SBMLCompartment))
    id = Compartment_getId(SBMLCompartment);
    SBMLCompartment = Compartment_setName(SBMLCompartment, id);
    SBMLCompartment = Compartment_setId(SBMLCompartment, '');
end;
