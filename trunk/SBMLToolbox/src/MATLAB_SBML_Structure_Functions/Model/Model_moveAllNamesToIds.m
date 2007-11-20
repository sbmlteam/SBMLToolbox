function SBMLModel = Model_moveAllNamesToIds(SBMLModel)
%
%   Model_moveAllNamesToIds 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with all names moved to the id field 
%               (unless the id field is already set)
%
%       SBMLModel = Model_moveAllNamesToIds(SBMLModel)


%  Filename    :   Model_moveAllNamesToIds.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   09-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
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
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):


% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_moveAllNamesToIds(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_moveAllNamesToIds(SBMLModel)', 'no id field in a level 1 model'));    
end;

SBMLModel = Model_moveNameToId(SBMLModel);

for i = 1:length(SBMLModel.functionDefinition)
    SBMLModel.functionDefinition(i) = FunctionDefinition_moveNameToId(SBMLModel.functionDefinition(i));
end;

for i = 1:length(SBMLModel.unitDefinition)
    SBMLModel.unitDefinition(i) = UnitDefinition_moveNameToId(SBMLModel.unitDefinition(i));
end;

for i = 1:length(SBMLModel.compartment)
    SBMLModel.compartment(i) = Compartment_moveNameToId(SBMLModel.compartment(i));
end;

for i = 1:length(SBMLModel.species)
    SBMLModel.species(i) = Species_moveNameToId(SBMLModel.species(i));
end;

for i = 1:length(SBMLModel.parameter)
    SBMLModel.parameter(i) = Parameter_moveNameToId(SBMLModel.parameter(i));
end;

for i = 1:length(SBMLModel.reaction)
    SBMLModel.reaction(i) = Reaction_moveNameToId(SBMLModel.reaction(i));
end;

for i = 1:length(SBMLModel.event)
    SBMLModel.event(i) = Event_moveNameToId(SBMLModel.event(i));
end;

