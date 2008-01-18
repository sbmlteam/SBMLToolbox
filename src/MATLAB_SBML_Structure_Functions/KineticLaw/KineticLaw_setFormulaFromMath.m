function SBMLKineticLaw = KineticLaw_setFormulaFromMath(SBMLKineticLaw)
%
%   KineticLaw_setFormulaFromMath 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the model with formula set to the math field 
%
%       SBMLKineticLaw = KineticLaw_setFormulaFromMath(SBMLKineticLaw)

%  Filename    :   KineticLaw_setFormulaFromMath.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
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



% check that input is correct
if (~isstruct(SBMLKineticLaw))
  error(sprintf('%s\n%s', ...
    'KineticLaw_setFormulaFromMath(SBMLKineticLaw)', ...
    'first argument must be an SBML KineticLaw structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLKineticLaw);

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'KineticLaw_setFormulaFromMath(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'KineticLaw_setFormulaFromMath(SBMLKineticLaw)', 'no math field in a level 1 model'));    
end;

math = KineticLaw_getMath(SBMLKineticLaw);
SBMLKineticLaw = KineticLaw_setFormula(SBMLKineticLaw, math);
