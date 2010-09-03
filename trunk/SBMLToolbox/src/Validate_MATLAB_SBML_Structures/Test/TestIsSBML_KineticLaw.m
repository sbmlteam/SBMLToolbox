function fail = TestIsSBML_KineticLaw

%  Filename    :   TestIsSBML_KineticLaw.m
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


kl_l1 = struct('typecode', {'SBML_KINETIC_LAW'}, 'notes', {''}, 'annotation', {''},'formula', {''}, ...
    'parameter', {''}, 'timeUnits', {''}, 'substanceUnits', {''});

kl_l2 = struct('typecode', {'SBML_KINETIC_LAW'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'formula', {''}, ...
    'math', {''},'parameter', {''}, 'timeUnits', {''}, 'substanceUnits', {''});

kl_l2v2 = struct('typecode', {'SBML_KINETIC_LAW'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'formula', {''}, ...
    'math', {''},'parameter', {''}, 'sboTerm', {''});

kl_l2v3 = struct('typecode', {'SBML_KINETIC_LAW'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'formula', {''}, ...
    'math', {''},'parameter', {''}, 'sboTerm', {''});

kl_l3v1 = struct('typecode', {'SBML_KINETIC_LAW'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''}, ...
    'math', {''},'localParameter', {''}, 'sboTerm', {''});

fail = TestFunction('isSBML_KineticLaw', 2, 1, kl_l1, 1, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 3, 1, kl_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 3, 1, kl_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 2, 1, kl_l2, 2, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 3, 1, kl_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 3, 1, kl_l2v2, 2, 2, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 3, 1, kl_l2v3, 2, 3, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 3, 1, kl_l2v3, 2, 4, 1);
fail = fail + TestFunction('isSBML_KineticLaw', 3, 1, kl_l3v1, 3, 1, 1);










