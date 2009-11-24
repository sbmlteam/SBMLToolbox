function SBMLCompartment = Compartment_unsetVolume(SBMLCompartment)
%
%   Compartment_unsetVolume 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the compartment with the volume unset
%               (i.e. volume = NAN)
%
%       SBMLCompartment = Compartment_unsetVolume(SBMLCompartment)

%  Filename    :   Compartment_unsetVolume.m
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
      'Compartment_unsetVolume(SBMLCompartment)', ...
      'argument must be an SBML compartment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLCompartment);

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Compartment_unsetVolume(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Compartment_unsetVolume(SBMLCompartment)', 'no volume field in a level 2 model'));    
end;

if exist('OCTAVE_VERSION')
  warning off Octave:divide-by-zero;
else
  warning off MATLAB:divideByZero;
end;

SBMLCompartment.volume = 0/0;
SBMLCompartment.isSetVolume = 0;

if exist('OCTAVE_VERSION')
  warning off Octave:divide-by-zero;
else
  warning off MATLAB:divideByZero;
end;
