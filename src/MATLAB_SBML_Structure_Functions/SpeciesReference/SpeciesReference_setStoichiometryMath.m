function SBMLSpeciesReference = SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)
%
%   SpeciesReference_setStoichiometryMath 
%             takes  1) an SBMLSpeciesReference structure 
%             and    2) a string representing the stoichiometryMath to be set
%
%             and returns 
%               the speciesreference with the stoichiometryMath set
%
%       SBMLSpeciesReference = SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, 'stoichiometryMath')

%  Filename    :   SpeciesReference_setStoichiometryMath.m
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
if (~isstruct(SBMLSpeciesReference))
    error(sprintf('%s', ...
      'argument must be an SBML SpeciesReference structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpeciesReference);

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)', 'first argument must be an SBML speciesreference structure'));
elseif (~ischar(stoichiometryMath))
    error(sprintf('SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)\n%s', 'second argument must be a string representing the stoichiometryMath of the speciesreference'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)', 'no stoichiometryMath field in a level 1 model'));    
end;

SBMLSpeciesReference.stoichiometryMath = stoichiometryMath;
