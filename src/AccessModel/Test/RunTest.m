function y = RunTest()


%  Filename    :   RunTest.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
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


test = 0;
Totalfail = 0;

test = test + 8;
fail = TestDetermineSpeciesRoleInReaction;
if (fail > 0)
    disp('DetermineSpeciesRoleInReaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestGetAllParameters;
if (fail > 0)
    disp('GetAllParameters failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestGetAllParametersUnique;
if (fail > 0)
    disp('GetAllParametersUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 3;
fail = TestGetGlobalParameters;
if (fail > 0)
    disp('GetGlobalParameters failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterFromReaction;
if (fail > 0)
    disp('GetParameterFromReaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterFromReactionUnique;
if (fail > 0)
    disp('GetParameterFromReactionUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestGetRateLawsFromReactions;
if (fail > 0)
    disp('GetRateLawsFromReactions failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetRateLawsFromRules;
if (fail > 0)
    disp('GetRateLawsFromRules failed');
end;
Totalfail = Totalfail + fail;

test = test + 3;
fail = TestGetSpecies;
if (fail > 0)
    disp('GetSpecies failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesAlgebraicRules;
if (fail > 0)
    disp('GetSpeciesAlgebraicRules failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesAssignmentRules;
if (fail > 0)
    disp('GetSpeciesAssignmentRules failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestGetStoichiometryMatrix;
if (fail > 0)
    disp('GetStoichiometryMatrix failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestIsSpeciesInReaction;
if (fail > 0)
    disp('IsSpeciesInReaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 5;
fail = TestGetCompartments;
if (fail > 0)
    disp('GetCompartments failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetCompartmentTypes;
if (fail > 0)
    disp('GetCompartmentTypes failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesTypes;
if (fail > 0)
    disp('GetSpeciesTypes failed');
end;
Totalfail = Totalfail + fail;

test = test + 3;
fail = TestGetStoichiometrySparse;
if (fail > 0)
    disp('GetStoichiometrySparse failed');
end;
Totalfail = Totalfail + fail;


disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));

y = Totalfail;
