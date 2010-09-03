function fail = TestIsSBML_LocalParameter

%  Filename    :   TestIsSBML_LocalParameter.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: TestIsSBML_Parameter.m 7155 2008-06-26 20:24:00Z mhucka $
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


p_l3 = struct('typecode', {'SBML_LOCAL_PARAMETER'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'id', {''}, 'value', {''}, 'units', {''}, 'sboTerm', {''}, 'isSetValue', {''});

fail = TestFunction('isSBML_LocalParameter', 2, 1, p_l3, 1, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 3, 1, p_l3, 1, 1, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 3, 1, p_l3, 1, 2, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 2, 1, p_l3, 2, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 3, 1, p_l3, 2, 1, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 3, 1, p_l3, 2, 2, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 3, 1, p_l3, 2, 3, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 3, 1, p_l3, 2, 4, 0);
fail = fail + TestFunction('isSBML_LocalParameter', 3, 1, p_l3, 3, 1, 1);










