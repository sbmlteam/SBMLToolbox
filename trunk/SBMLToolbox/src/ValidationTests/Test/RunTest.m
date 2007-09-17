function y = RunTest()


%  Filename    :   RunTest.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
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


test = 0;
Totalfail = 0;

test = test + 6;
fail = TestIsSBML_AlgebraicRule;
if (fail > 0)
    disp('isSBML_AlgebraicRule failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_AssignmentRule;
if (fail > 0)
    disp('isSBML_AssignmentRule failed');
end;
Totalfail = Totalfail + fail;

test = test + 7;
fail = TestIsSBML_Compartment;
if (fail > 0)
    disp('isSBML_Compartment failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_CompartmentVolumeRule;
if (fail > 0)
    disp('isSBML_CompartmentVolumeRule failed');
end;
Totalfail = Totalfail + fail;

test = test + 7;
fail = TestIsSBML_Event;
if (fail > 0)
    disp('isSBML_Event failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_EventAssignment;
if (fail > 0)
    disp('isSBML_EventAssignment failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_FunctionDefinition;
if (fail > 0)
    disp('isSBML_FunctionDefinition failed');
end;
Totalfail = Totalfail + fail;

test = test + 7;
fail = TestIsSBML_KineticLaw;
if (fail > 0)
    disp('isSBML_KineticLaw failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_ModifierSpeciesReference;
if (fail > 0)
    disp('isSBML_ModifierSpeciesReference failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_Parameter;
if (fail > 0)
    disp('isSBML_Parameter failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_ParameterRule;
if (fail > 0)
    disp('isSBML_ParameterRule failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_RateRule;
if (fail > 0)
    disp('isSBML_RateRule failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_Reaction;
if (fail > 0)
    disp('isSBML_Reaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_Species;
if (fail > 0)
    disp('isSBML_Species failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_SpeciesConcentrationRule;
if (fail > 0)
    disp('isSBML_SpeciesConcentrationRule failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_SpeciesReference;
if (fail > 0)
    disp('isSBML_SpeciesReference failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_UnitDefinition;
if (fail > 0)
    disp('isSBML_UnitDefinition failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_Unit;
if (fail > 0)
    disp('isSBML_Unit failed');
end;
Totalfail = Totalfail + fail;

test = test + 8;
fail = TestIsSBML_CompartmentType;
if (fail > 0)
    disp('isSBML_CompartmentType failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_SpeciesType;
if (fail > 0)
    disp('isSBML_SpeciesType failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_InitialAssignment;
if (fail > 0)
    disp('isSBML_InitialAssignment failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestIsSBML_Constraint;
if (fail > 0)
    disp('isSBML_Constraint failed');
end;
Totalfail = Totalfail + fail;


disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));
