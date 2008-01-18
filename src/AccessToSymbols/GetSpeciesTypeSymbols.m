function varargout = GetSpeciesTypeSymbols(SBMLModel)
% GetSpeciesTypeSymbols takes an SBMLModel 
% and returns 
%           1) an array of symbols representing all speciesTypes within the model 
%           2) an array of character names of the symbols

%--------------------------------------------------------------------------
%
%  Filename    : GetSpeciesTypeSymbols.m
%  Description : takes a SBMLModel and returns an array of character names representing all speciesTypes 
%                   and an array of the initial values of each speciesType
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetSpeciesTypeSymbols(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% determine the number of speciesTypes within the model
NumSpeciesTypes = length(SBMLModel.speciesType);

%------------------------------------------------------------
% loop through the list of speciesTypes
for i = 1:NumSpeciesTypes
    
    name = SBMLModel.speciesType(i).id;
    
    % create a symbol from the species name
    % save into an array of species symbols
    % and array of the character names
    SymbolArray(i) = sym(name);
    CharArray{i} = name;
    
end;

%--------------------------------------------------------------------------
% assign output

if (NumSpeciesTypes ~= 0)
    varargout{1} = SymbolArray;
    varargout{2} = CharArray;
else
    varargout{1} = [];
    varargout{2} = [];
end;