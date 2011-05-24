function SBMLInitialAssignment = InitialAssignment_setMath(SBMLInitialAssignment, math)
%
% InitialAssignment_setMath
%    takes an SBML InitialAssignment structure
%    and the math to be set
%
%    returns
%      the InitialAssignment with the new value for the math attribute

%  Filename    :   InitialAssignment_setMath.m
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


%get level and version and check the input arguments are appropriate

[level, version] = GetLevelVersion(SBMLInitialAssignment);

if isfield(SBMLInitialAssignment, 'math')
	if ~ischar(math)
		error('math must be character array') ;
	else
		SBMLInitialAssignment.math = math;
	end;
else
	error('math not an attribute on SBML L%dV%d InitialAssignment', level, version);
end;

