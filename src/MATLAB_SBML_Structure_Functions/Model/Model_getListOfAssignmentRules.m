function AssignRules = Model_getListOfAssignmentRules(SBMLModel)
% Model_getListOfAssignmentRules takes an SBMLModel and returns an array
% of the Assignment rules
% i.e. those with typecode:   'SBML_ASSIGNMENT_RULE'
%                             'SBML_SPECIES_CONCENTRATION_RULE'
%                             'SBML_COMPARTMENT_VOLUME_RULE'
%                             'SBML_PARAMETER_RULE'
 
%
%  Filename    : Model_getListOfAssignmentRules.m
%  Description : takes a SBMLModel and returns the assignment rules in the model
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-11-09
%  Revision    : $Id$
%  Source      : $Source $
%
%  Copyright 2003 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):

%  Filename    :   Model_getListOfAssignmentRules.m
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

j = 1;
for i = 1:length(SBMLModel.rule)
    if (strcmp(SBMLModel.rule(i).typecode, 'SBML_ASSIGNMENT_RULE'))
        AssignRules(j) = SBMLModel.rule(i);
        j = j + 1;
    elseif (SBMLModel.SBML_level == 1)
        if ((strcmp(SBMLModel.rule(i).typecode, 'SBML_SPECIES_CONCENTRATION_RULE')) & (strcmp(SBMLModel.rule(i).type, 'scalar')))
            AssignRules(j) = SBMLModel.rule(i);
            j = j + 1;
        elseif ((strcmp(SBMLModel.rule(i).typecode, 'SBML_COMPARTMENT_VOLUME_RULE')) & (strcmp(SBMLModel.rule(i).type, 'scalar')))
            AssignRules(j) = SBMLModel.rule(i);
            j = j + 1;
        elseif ((strcmp(SBMLModel.rule(i).typecode, 'SBML_PARAMETER_RULE')) & (strcmp(SBMLModel.rule(i).type, 'scalar')))
            AssignRules(j) = SBMLModel.rule(i);
            j = j + 1;
        end;
             
    end;
end;

if (j == 1)
    AssignRules = '';
end;
