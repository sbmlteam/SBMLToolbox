function fbcEnabled = isBindingFbcEnabled(varargin)
% fbcEnabled = isBindFbcEnabled(path_to_fbc_file(optional))
%
% Takes
%
% 1. path_to_fbc_file, the path to the fbc.xml file (optional)
%
% Returns
%
% 1. fbcEnabled = 
%  - 1 if the executables are enabled with fbc support
%  - 0 otherwise
%
% *NOTE:* if no argument is supplied it is assumed that the path is
%    './test/test-data/fbc.xml'
%

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

% assume not enabled
fbcEnabled = 0;

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
      fbcEnabled = 1;
    end;    
  end;

end;
