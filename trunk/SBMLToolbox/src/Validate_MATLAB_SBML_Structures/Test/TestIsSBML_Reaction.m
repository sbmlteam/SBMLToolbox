function fail = TestIsSBML_Reaction

%  Filename    :   TestIsSBML_Reaction.m
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


r_l1 = struct('typecode', {'SBML_REACTION'}, 'notes', {''}, 'annotation', {''},'name', {''}, 'reactant', {''}, ...
    'product', {''}, 'kineticLaw', {''}, 'reversible', {''}, 'fast', {''});

r_l2 = struct('typecode', {'SBML_REACTION'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'reactant', {''}, 'product', {''}, 'modifier', {''}, 'kineticLaw', {''}, 'reversible', {''}, ...
    'fast', {''}, 'isSetFast', {''});

r_l2v2 = struct('typecode', {'SBML_REACTION'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'id', {''}, 'reactant', {''}, 'product', {''}, 'modifier', {''}, 'kineticLaw', {''}, 'reversible', ...
    {''}, 'fast', {''}, 'sboTerm', {''}, 'isSetFast', {''});

r_l3v1 = struct('typecode', {'SBML_REACTION'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'id', {''}, 'reactant', {''}, 'product', {''}, 'modifier', {''}, 'kineticLaw', {''}, 'reversible', ...
    {''}, 'fast', {''}, 'sboTerm', {''}, 'compartment', {''}, 'isSetFast', {''});

fail = TestFunction('isSBML_Reaction', 2, 1, r_l1, 1, 1);
fail = fail + TestFunction('isSBML_Reaction', 3, 1, r_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_Reaction', 3, 1, r_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_Reaction', 2, 1, r_l2, 2, 1);
fail = fail + TestFunction('isSBML_Reaction', 3, 1, r_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_Reaction', 3, 1, r_l2v2, 2, 2, 1);
fail = fail + TestFunction('isSBML_Reaction', 3, 1, r_l2v2, 2, 3, 1);
fail = fail + TestFunction('isSBML_Reaction', 3, 1, r_l2v2, 2, 4, 1);
fail = fail + TestFunction('isSBML_Reaction', 3, 1, r_l3v1, 3, 1, 1);










