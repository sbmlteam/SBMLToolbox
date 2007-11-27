function y = TestFunction(varargin)


%  Filename    :   TestFunction.m
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

y = 0;
if (nargin < 3)
    error('Need at least 3 inputs');
end;

func = varargin{1};
fhandle = str2func(func);

number_in = varargin{2};
number_out = varargin{3};

if (nargin < 3+number_in+number_out)
    error('incorrect number of arguments');
end;

start_out = 4 + number_in;

fail = 0;
switch number_out
    case 0
        switch number_in
            case 1
                [a] = feval(fhandle, varargin{4});
            case 2
                [a] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~isempty(a);
    case 1
        switch number_in
            case 1
                [a] = feval(fhandle, varargin{4});
            case 2
                [a] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~isequal(a, varargin{start_out});
    case 2
        switch number_in
            case 1
                [a, b] = feval(fhandle, varargin{4});
            case 2
                [a, b] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~isequal(a, varargin{start_out});
        fail = fail + ~isequal(b, varargin{start_out+1});
    case 3
        switch number_in
            case 1
                [a, b, c] = feval(fhandle, varargin{4});
            case 2
                [a, b, c] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~isequal(a, varargin{start_out});
        fail = fail + ~isequal(b, varargin{start_out+1});
        fail = fail + ~isequal(c, varargin{start_out+2});
    otherwise
        error('too many output');
end;
 
if (fail > 0)
    y = 1;
end;



