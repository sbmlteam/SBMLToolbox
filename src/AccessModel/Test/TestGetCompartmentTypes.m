function fail = TestGetCompartmentTypes
% GetCompartmentTypes takes a SBMLModel 
% and returns 
%           1) an array of character names of all compartmentTypes within the model 
%


%  Filename    :   TestGetCompartmentTypes.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   30-Nov-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
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


m = TranslateSBML('../../Test/test-data/l2v2-newComponents.xml');

names = {'mitochondria'};

fail = TestFunction('GetCompartmentTypes', 1, 1, m, names);


