function [fail, num, message] = testFluxObjective()
%
% testFluxObjective
%
%    returns
%      the number of fails
%      the number of tests
%      and an array of any messages

%  Filename    :   %  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: $
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2016 jointly by the following organizations: 
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


fail = 0;
num = 0;
message = {};
warning('off', 'Warn:InvalidLV');

disp('Testing FluxObjective');

disp('Testing L1V1');
obj = FluxObjective_create(1, 1);
attributes = {};
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L1V2');
obj = FluxObjective_create(1, 2);
attributes = {};
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L2V1');
obj = FluxObjective_create(2, 1);
attributes = {};
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L2V2');
obj = FluxObjective_create(2, 2);
attributes = {};
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L2V3');
obj = FluxObjective_create(2, 3);
attributes = {};
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L2V4');
obj = FluxObjective_create(2, 4);
attributes = {};
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L3V1 FBC V1');
obj = FluxObjective_create(3, 1, 1);
attributes = {...
              {'Metaid', 1}...
              {'SBOTerm', 2}...
              {'Fbc_reaction', 1}...
              {'Fbc_coefficient', 3}...
              };
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L3V1 FBC V2');
obj = FluxObjective_create(3, 1, 2);
attributes = {...
              {'Metaid', 1}...
              {'SBOTerm', 2}...
              {'Fbc_reaction', 1}...
              {'Fbc_coefficient', 3}...
              };
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L3V1 FBC V1');
obj = FluxObjective_create(3, 1);
attributes = {...
              {'Metaid', 1}...
              {'SBOTerm', 2}...
              {'Fbc_reaction', 1}...
              {'Fbc_coefficient', 3}...
              };
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp('Testing L3V1 FBC V1');
obj = FluxObjective_create(3);
attributes = {...
              {'Metaid', 1}...
              {'SBOTerm', 2}...
              {'Fbc_reaction', 1}...
              {'Fbc_coefficient', 3}...
              };
[fail, num, message] = testObject(obj, attributes, 'FluxObjective', fail, num, message);

disp(sprintf('Number tests: %d', num));
disp(sprintf('Number fails: %d', fail));
disp(sprintf('Pass rate: %d', ((num-fail)/num)*100));



warning('on', 'Warn:InvalidLV');
