function y = test_fbc_valid(varargin)

%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->

fbcBindingEnabled = 1;

if (nargin == 0)
  if isBindingFbcEnabled('../../test/test-data/fbc.xml') == 0
    disp ('The libsbml binding for fbc is not enabled');
    disp ('not all tests can be run');
    fbcBindingEnabled = 0;
  end;
else
  fbcBindingEnabled = varargin{1};
end;



test = 0;
Totalfail = 0;

test = test + 14;
fail = TestIsSBML_FBC_FluxBound;
if (fail > 0)
    disp('isSBML_FBC_FluxBound failed');
end;
Totalfail = Totalfail + fail;

% m = TranslateSBML('../../Test/test-data/l3v1core.xml');
% 
% fd  = m.functionDefinition(1);
% ud  = m.unitDefinition(1);
% c   = m.compartment(1);
% s   = m.species(1);
% p   = m.parameter(1);
% ia  = m.initialAssignment(1);
% ar  = m.rule(1);
% asr = m.rule(2);
% rr  = m.rule(3);
% con = m.constraint(1);
% r   = m.reaction(1);
% e   = m.event(1);
% 
% test = test + 15;
% 
% fail = 0;
% 
% pass = isValidSBML_Model(m);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Model failed');
% end;
% 
% pass = isSBML_FunctionDefinition(fd,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 FunctionDefinition failed');
% end;
% 
% pass = isSBML_UnitDefinition(ud,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 UnitDefinition failed');
% end;
% 
% pass = isSBML_Compartment(c,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Compartment failed');
% end;
% 
% pass = isSBML_Species(s,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Species failed');
% end;
% 
% pass = isSBML_Parameter(p,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Parameter failed');
% end;
% 
% pass = isSBML_InitialAssignment(ia,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 InitialAssignment failed');
% end;
% 
% pass = isSBML_AlgebraicRule(ar,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Rule 1 failed');
% end;
% 
% pass = isSBML_AssignmentRule(asr,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Rule 2 failed');
% end;
% 
% pass = isSBML_RateRule(rr,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Rule 3 failed');
% end;
% 
% pass = isSBML_Constraint(con,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Constraint failed');
% end;
% 
% pass = isSBML_Reaction(r,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Reaction failed');
% end;
% 
% pass = isSBML_Event(e,3, 1);
% if (pass == 0)
%     fail = fail + 1;
%     disp('l3v1 Event failed');
% end;
% 
% Totalfail = Totalfail + fail;
% 
% try
%   m = Model_create();
% catch
%   Totalfail = Totalfail + 1;
%   disp('creating model failed');
% end;
% 
% if (isempty(m))
%   Totalfail = Totalfail + 1;
%   disp('creating model failed');
% end;


disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));
