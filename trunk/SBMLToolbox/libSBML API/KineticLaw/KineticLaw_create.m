function KineticLaw = KineticLaw_create(varargin)
%
%   KineticLaw_create 
%             optionally takes an SBML level 
%
%             and returns 
%               a kineticLaw structure of the required level
%               (default level = 2)
%
%       KineticLaw = KineticLaw_create
%    OR KineticLaw = KineticLaw_create(sbmlLevel)


%  Filename    :   KineticLaw_create.m
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


%default level = 2
sbmlLevel = 2;
if (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'KineticLaw_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
elseif (nargin > 1)
    error(sprintf('%s\n%s\n%s', 'KineticLaw_create(sbmlLevel)', 'requires either no arguments or just one', 'SEE help KineticLaw_create'));
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'parameter', 'timeUnits', 'substanceUnits'};
    Values = {'SBML_KINETIC_LAW', '', '', '', [], '', ''};
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'value', {}, 'units', {}, 'isSetValue', {});
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'math', 'parameter', 'timeUnits', 'substanceUnits'};
    Values = {'SBML_KINETIC_LAW', '', '', '', '', [], '', ''};
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, 'constant', {}, 'isSetValue', {});
end;

KineticLaw = cell2struct(Values, SBMLfieldnames, 2);
KineticLaw = setfield(KineticLaw, 'parameter', parameter);

%check created structure is appropriate
if (~isSBML_KineticLaw(KineticLaw, sbmlLevel))
    KineticLaw = [];
    warning('Failed to create kineticLaw');
end;
