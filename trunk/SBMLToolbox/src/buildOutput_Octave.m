function buildOutput_Octave (varargin)
% buildOutput_Octave(path_to_libSBML_include, path_to_libSBML_lib)
%       takes 
%           1) path to the libSBML include files 
%           2) path to the libSBML lib file
%       and builds the OutputSBML.mex file in Octave
%
%--------------------------------------------------------------------------


%  @file       : buildOutput_Octave.m
%  @brief      : builds the OutputSBML executable for Octave
%  @author     : Sarah Keating
%
%  $Id: $
%  $Source$
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


if (nargin ~= 2)
  text = sprintf('%s\n%s\n%s', 'buildOutput_Octave requires 2 arguments.', ...
    'The first should be the path to the libSBML include directory.', ...
    'The second should be the path to the libSBML .lib file.');
  error(text);
end;

include_dir = sprintf('-I\\"%s\\"', varargin{1})
library_dir = varargin{2}

fhandle = str2func('mkoctfile');

feval(fhandle, '--mex',  'OutputSBML.c',  '-DUSE_OCTAVE', include_dir, '-lbz2 -liconv', library_dir);