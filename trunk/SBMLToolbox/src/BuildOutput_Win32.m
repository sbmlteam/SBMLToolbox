function y = BuildOutput_Win32(varargin)
% BuildOutput_Win32 builds the OutputSBML executable in windows
% environment

%
%
%  Filename    : BuildOutput_Win32.m
%  Description : builds the OutputSBML executable
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRI
%  Created     : 2004-08-23
%  Revision    : $Id$
%  Source      : $Source$
%

if (nargin ~= 2)
  text = sprintf('%s\n%s\n%s', 'BuildOutput_Win32 requires 2 arguments.', ...
    'The first should be the path to the libSBML include directory.', ...
    'The second should be the path to the libSBML .lib file.');
  error(text);
end;

fhandle = str2func('mex');

include_dir = sprintf('-I''%s''', varargin{1});
library_dir = varargin{2};

feval(fhandle, 'OutputSBML.c', include_dir, library_dir);