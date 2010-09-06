function fail = TestIsSBML_Compartment

%  Filename    :   TestIsSBML_Compartment.m
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


c_l1 = struct('typecode', {'SBML_COMPARTMENT'}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'volume', {''}, 'units', {''}, 'outside', {''}, 'isSetVolume', {''});

c_l2 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'spatialDimensions', {''}, 'size', {''}, 'units', {''}, 'outside', {''}, 'constant', {''}, ...
    'isSetSize', {''},'isSetVolume', {''});

c_l2v2 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'compartmentType', {''}, 'spatialDimensions', {''}, 'size', {''}, 'units', {''}, 'outside', {''}, ...
    'constant', {''}, 'isSetSize', {''},'isSetVolume', {''});

c_l2v3 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'compartmentType', {''}, 'spatialDimensions', {''}, 'size', {''}, 'units', {''}, 'outside', {''}, ...
    'constant', {''}, 'isSetSize', {''},'isSetVolume', {''}, 'sboTerm', {''});

c_l2v4 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'compartmentType', {''}, 'spatialDimensions', {''}, 'size', {''}, 'units', {''}, 'outside', {''}, ...
    'constant', {''}, 'isSetSize', {''},'isSetVolume', {''}, 'sboTerm', {''});

c_l3v1 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'spatialDimensions', {''}, 'size', {''}, 'units', {''}, ...
    'constant', {''}, 'isSetSize', {''},'isSetSpatialDimensions', {''}, 'sboTerm', {''});


fail = TestFunction('isSBML_Compartment', 2, 1, c_l1, 1, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_Compartment', 2, 1, c_l2, 2, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l2v2, 2, 2, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l2v3, 2, 3, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l2v4, 2, 4, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l3v1, 3, 1, 1);









