function array = Model_getListOfByTypecode(SBMLModel, SBMLTypecode)
%
%   Model_getListOfByTypecode 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing an SBMLTypecode
%
%             and returns 
%               an array of SBML structures of the given type defined within the model
%
%       array = Model_getListOfByTypecode(SBMLModel, 'SBMLTypecode')


%  Filename    :   Model_getListOfByTypecode.m
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
    error(sprintf('%s\n%s', 'Model_getListOfByTypecode(SBMLModel, SBMLTypecode)', 'first argument must be an SBML model structure'));
elseif (~CheckTypecode(SBMLTypecode))
    error(sprintf('%s\n%s', 'Model_getListOfByTypecode(SBMLModel, SBMLTypecode)', 'second argument must be a string representing an SBML typecode'));   
end;

switch (SBMLTypecode)
    case 'SBML_FUNCTION_DEFINITION'
        array = SBMLModel.functionDefinition;
    case 'SBML_UNIT_DEFINITION'
        array = SBMLModel.unitDefinition;
    case 'SBML_COMPARTMENT'
        array = SBMLModel.compartment;
    case 'SBML_SPECIES'
        array = SBMLModel.species;
    case 'SBML_PARAMETER'
        array = SBMLModel.parameter;
    case {'SBML_ASSIGNMENT_RULE', 'SBML_ALGEBRAIC_RULE', 'SBML_RATE_RULE', 'SBML_SPECIES_CONCENTRATION_RULE', 'SBML_COMPARTMENT_VOLUME_RULE', 'SBML_PARAMETER_RULE'}
        array = SBMLModel.rule;
    case 'SBML_REACTION'
        array = SBMLModel.reaction;
    case 'SBML_EVENT'
        array = SBMLModel.event;
    otherwise
        array = [];
end;

%------------------------------------------------------------------------------------
function value = CheckTypecode(SBMLTypecode)
%
%   CheckTypecode 
%             takes a string representing an SBMLTypecode
%             and returns 1 if it is a valid typecode and 0 otherwise
%
%       value = CheckTypecode('SBMLTypecode')

ValidTypecodes = {'SBML_COMPARTMENT', 'SBML_EVENT', 'SBML_FUNCTION_DEFINITION', 'SBML_PARAMETER', 'SBML_REACTION', 'SBML_SPECIES', ...
    'SBML_UNIT_DEFINITION', 'SBML_ASSIGNMENT_RULE', 'SBML_ALGEBRAIC_RULE', 'SBML_RATE_RULE', 'SBML_SPECIES_CONCENTRATION_RULE', ...
    'SBML_COMPARTMENT_VOLUME_RULE', 'SBML_PARAMETER_RULE'};


value = 1;

if (~ischar(SBMLTypecode))
    value = 0;
elseif (~ismember(SBMLTypecode, ValidTypecodes))
    value = 0;
end;
