function species = Model_getListOfSpecies(SBMLModel)
%
%   Model_getListOfSpecies 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML species structures defined within the model
%
%       species = Model_getListOfSpecies(SBMLModel)

%  Filename    :   Model_getListOfSpecies.m
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
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfSpecies(SBMLModel)', 'argument must be an SBML model structure'));
end;

species = SBMLModel.species;
