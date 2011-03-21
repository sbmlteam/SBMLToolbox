function SBMLUnit = Unit_setExponent(SBMLUnit, exponent)
%
%   Unit_setExponent 
%             takes  1) an SBMLUnit structure 
%             and    2) an integer representing the exponent to be set
%
%             and returns 
%               the unit with the exponent set
%
%       SBMLUnit = Unit_setExponent(SBMLUnit, exponent)

%  Filename    :   Unit_setExponent.m
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
if (~isstruct(SBMLUnit))
    error(sprintf('%s', ...
      'argument must be an SBML Unit structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLUnit);

if (~isSBML_Unit(SBMLUnit, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Unit_setExponent(SBMLUnit, exponent)', 'first argument must be an SBML model structure'));
elseif (~isIntegralNumber(exponent))
    error(sprintf('Unit_setExponent(SBMLUnit, exponent)\n%s', 'second argument must be an integer representing the exponent of the unit'));
end;

SBMLUnit.exponent = int32(exponent);
