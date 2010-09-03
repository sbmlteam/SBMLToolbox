function fail = TestIsSBML_Parameter

%  Filename    :   TestIsSBML_Parameter.m
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


p_l1 = struct('typecode', {'SBML_PARAMETER'}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'value', {''}, 'units', {''}, 'isSetValue', {''});

p_l2 = struct('typecode', {'SBML_PARAMETER'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'id', {''}, 'value', {''}, 'units', {''}, 'constant', {''}, 'isSetValue', {''});

p_l2v2 = struct('typecode', {'SBML_PARAMETER'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'id', {''}, 'value', {''}, 'units', {''}, 'constant', {''}, 'sboTerm', {''}, 'isSetValue', {''});

fail = TestFunction('isSBML_Parameter', 2, 1, p_l1, 1, 1);
fail = fail + TestFunction('isSBML_Parameter', 3, 1, p_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_Parameter', 3, 1, p_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_Parameter', 2, 1, p_l2, 2, 1);
fail = fail + TestFunction('isSBML_Parameter', 3, 1, p_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_Parameter', 3, 1, p_l2v2, 2, 2, 1);
fail = fail + TestFunction('isSBML_Parameter', 3, 1, p_l2v2, 2, 3, 1);
fail = fail + TestFunction('isSBML_Parameter', 3, 1, p_l2v2, 2, 4, 1);
fail = fail + TestFunction('isSBML_Parameter', 3, 1, p_l2v2, 3, 1, 1);










