function value = CheckValidUnitKind(kind)%
% CheckValidUnitKind takes a string representing a unit kind 
%       and returns 
%           1 if it is valid 
%           0 otherwise


%  Filename    :   CheckValidUnitKind.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   09-Feb-2005
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


UNIT_KIND_STRINGS = {'ampere', 'becquerel', 'candela', 'Celsius', 'coulomb', 'dimensionless', 'farad',...
  'gram', 'gray', 'henry', 'hertz', 'item', 'joule', 'katal', 'kelvin', 'kilogram', 'liter', 'litre',...
  'lumen', 'lux', 'meter', 'metre', 'mole', 'newton', 'ohm', 'pascal', 'radian', 'second', 'siemens',...
  'sievert', 'steradian', 'tesla', 'volt', 'watt', 'weber', '(Invalid UnitKind)'};


value = 0;

if (ismember(kind, UNIT_KIND_STRINGS))
    value = 1;
end;