function fbcEnabled = isBindingFbcEnabled(varargin)
% Checks whether the version of libSBML has been built with 
% the FBC package extension enabled

% Filename    : isBindingFbcEnabled.m
% Description : check fbc status
% Author(s)   : SBML Team <sbml-team@caltech.edu>
% Organization: EMBL-EBI, Caltech
% Created     : 2011-02-08
%
% This file is part of libSBML.  Please visit http://sbml.org for more
% information about SBML, and the latest version of libSBML.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%  
% Copyright (C) 2006-2008 by the California Institute of Technology,
%     Pasadena, CA, USA 
%  
% Copyright (C) 2002-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. Japan Science and Technology Agency, Japan
% 
% This library is free software; you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as
% published by the Free Software Foundation.  A copy of the license
% agreement is provided in the file named "LICENSE.txt" included with
% this software distribution and also available online as
% http://sbml.org/software/libsbml/license.html

% assume not enabled
fbcEnabled = false;

if nargin == 0
  % no argument supplied so we must be in the fbc_package directory
  if exist('./test/test-data/fbc.xml') == 0
    error('%s%s\n%s %s', 'isBindingFbcEnabled requires a test file ', ...
      'therefore it must be run from the fbc_package directory', ...
      'or the full path to fbc_package/test/test-data/fbc.xml file', ...
      'can be supplied as an argument to the function');
  else
    [m, e] = TranslateSBML('./test/test-data/fbc.xml', 1, 0);

    if length(e) == 0
      fbcEnabled = true;
    end;    
  end;
else
  
  path_to_file = varargin{1};

  if (exist(path_to_file, 'file') == 7)
    error('%s%s\n%s %s', 'isBindingFbcEnabled requires a test file ', ...
      'therefore it must be run from the fbc_package directory', ...
      'or the full path to fbc_package/test/test-data/fbc.xml file', ...
      'can be supplied as an argument to the function');
  else
    [m, e] = TranslateSBML(path_to_file, 1, 0);

    if length(e) == 0
      fbcEnabled = true;
    end;    
  end;

end;
